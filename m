X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 02/12] completion: simplify __gitcomp
Date: Sun, 8 Apr 2012 17:11:31 +0300
Message-ID: <CAMP44s2vdEzn8_N=sauq-6OvqA+4tDtM9+yYYWuiQHgkZ2DyYA@mail.gmail.com>
References: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
	<1333854479-23260-3-git-send-email-felipe.contreras@gmail.com>
	<20120408124652.GN2289@goldbirke>
	<CAMP44s0nSH7ZjC4T=7pXS2MyAkZ133hOXa_tn3q4er+FbcOc_w@mail.gmail.com>
	<20120408132704.GB4103@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sun, 8 Apr 2012 14:11:42 +0000 (UTC)
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=SDL4K7NR9JjO0luHprnVaT43g51FTd/4fulztm3CLRg=;
        b=Zmhds/TETJT/tu1V2aXWhX7dh0mVFQHxJVfAUk1NsRgbOL+YAlgUxrH2r7CD4yJ/7F
         VR/CRCiKQQawtdl9j+UMOacoTU5rh6k0TBCMJ8UiIZxgUNFUEo0sBTDYQL439iYHsLmM
         a6qkZNyZwckvVPfTVoIEY5VK0+w17XpnlmlKc56WvgIn2N1U8V+GTC/HPGfu9+GKHEpB
         +ahlCKNKBRKspfwL2YBRDGO6oC0+iNqyY60wfDB6nlvf1e45fcUhdz5DoH3MtjROpShf
         GCyd8oNE5FsUjgrDME5MCo3xnxDf1JUhJE70+s4pf5LQBqslQv6ozPVvPE7YLnP89GI2
         Ii4w==
In-Reply-To: <20120408132704.GB4103@burratino>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195000>
Received: from vger.kernel.org ([209.132.180.67]) by plane.gmane.org with
 esmtp (Exim 4.69) (envelope-from <git-owner@vger.kernel.org>) id
 1SGsqB-0000p8-90 for gcvg-git-2@plane.gmane.org; Sun, 08 Apr 2012 16:11:39
 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755529Ab2DHOLd convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Apr 2012 10:11:33 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:41843 "EHLO
 mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1755421Ab2DHOLd convert rfc822-to-8bit (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 8 Apr 2012 10:11:33 -0400
Received: by eekc41 with SMTP id c41so960356eek.19 for <git@vger.kernel.org>;
 Sun, 08 Apr 2012 07:11:31 -0700 (PDT)
Received: by 10.213.19.207 with SMTP id c15mr261010ebb.67.1333894291807; Sun,
 08 Apr 2012 07:11:31 -0700 (PDT)
Received: by 10.213.19.67 with HTTP; Sun, 8 Apr 2012 07:11:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org

Hi,

I've looked at the history of __gitcomp and __gitcomp_nl, now I think
it makes sense to keep their arguments similar, at least for the time
being.

So I suggest this patch to be dropped.

On Sun, Apr 8, 2012 at 4:27 PM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> Felipe Contreras wrote:
>
>> So we should never make any cleanups because some custom completion
>> functions might theoretically break?
>
> No, tasteful cleanups that don't break custom completion functions ar=
e
> very welcome.
>
> Also if you have evidence that this is definitely (not just possibly)
> only a theoretical problem, then it would not be a regression. =C2=A0=
But I
> actually find it likely that custom completion code would have
> imitated the old completion code in git that used the suffix argument=
,
> so...
>
> Can you remind me what the benefit that the user is getting from this
> patch in exchange for us breaking their tab completion? =C2=A0The tit=
le
> ("simplify __gitcomp") tells me exactly nothing about its impact
> except that it is perhaps supposed to result in no behavior change.
>
> Sorry for the fuss and hope that helps,
> Jonathan



--=20
