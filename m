From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: GSoC draft proposal: Line-level history browser
Date: Mon, 22 Mar 2010 03:10:03 -0500
Message-ID: <20100322081003.GA26535@progeny.tock>
References: <81b0412b1003201335g7b37c51mfa3e2280210ebb7e@mail.gmail.com>
 <4BA544FC.7050007@gmail.com>
 <41f08ee11003202316w2fddc5f4jebda47f325451577@mail.gmail.com>
 <4BA61CF9.7040104@gmail.com>
 <41f08ee11003212048q1950eb3s95f1caf7ba640874@mail.gmail.com>
 <7vfx3tvv9y.fsf@alter.siamese.dyndns.org>
 <41f08ee11003212134s586aa71cs23255d02f38d53d1@mail.gmail.com>
 <7vhbo8syyf.fsf@alter.siamese.dyndns.org>
 <41f08ee11003220031p6fda651eycff2641df10864da@mail.gmail.com>
 <7v7hp4n6qn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bo Yang <struggleyb.nku@gmail.com>, gitzilla@gmail.com,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 22 09:09:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ntch2-0002RC-FC
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 09:09:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754021Ab0CVIIz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Mar 2010 04:08:55 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:56277 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753581Ab0CVIIx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 04:08:53 -0400
Received: by ywh2 with SMTP id 2so1704612ywh.33
        for <git@vger.kernel.org>; Mon, 22 Mar 2010 01:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Dl7v46VogffhyxK4I4JUsGNVWRmoB4+QxverldsUWFc=;
        b=GnTcbjrKsSy0zUQgba1RtM2FLk769MXNYTfh2vrxnbiNkf0dorWCUUti1g4ZAU1psE
         mk62mO6QyFc6Fow3Y3u8Hp8P/S5214psv/RDLwdM690vJ2WpOVQ3zIcDp12D/nfxZ0iM
         sLy7vWozcM2lRlaesNfzuZiS7iv/XnPjWMCLA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=UWmc42gIZwgy+hyoi6dW/mEtJxt5sDVurXitNnZN59pXd5ADnqaXFb5JpQ/gDriyoa
         OgodWiT72E7xSfIbvjl08JmCEn8477UtM3gCU3o4tW1eYeQwwJvvYSJ6/Trflkoq9B0w
         wmyow+7KjoUJYNtTxOvSHmY1hGCfbbWSgpyHc=
Received: by 10.101.178.8 with SMTP id f8mr9942162anp.213.1269245332510;
        Mon, 22 Mar 2010 01:08:52 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm3032567iwn.4.2010.03.22.01.08.51
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 22 Mar 2010 01:08:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v7hp4n6qn.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142909>

Junio C Hamano wrote:

> I am actually questioning the existence of "recursively and deeply to=
 find
> more"; the reason blame stopped at a particular commit is exactly bec=
ause
> there is no more

Hmm, I can imagine some (mutually inconsistent) heuristics:

 - Suppose in the blamed commit a single isolated line changed.  Then
   it is clear where to look next.

 - If the mystery code is at the beginning of the file (resp.
   beginning of a diff -C0 hunk), maybe it was based on the line at the
   same position within the previous commit.

 - Take the line with the lowest Levenshtein distance from the mystery
   code.

 - Expect certain common patterns of change: substituted words,
   whitespace changes, added arguments for a function, things like that=
=2E

That said, I still don=E2=80=99t have a clear picture of a basic strate=
gy.

Interested,
Jonathan
