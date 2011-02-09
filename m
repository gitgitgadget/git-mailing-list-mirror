From: Joshua Juran <jjuran@gmail.com>
Subject: Re: [PATCH 1.8.0] add: make "add -u" update full tree without pathspec
Date: Wed, 9 Feb 2011 02:58:15 -0800
Message-ID: <9CBA512E-D62E-483C-BEBD-D9E41083756E@gmail.com>
References: <1297045643-26697-1-git-send-email-pclouds@gmail.com> <7vsjw0v11p.fsf@alter.siamese.dyndns.org> <AANLkTimG6s5vSCnisJCt-EXkcJGXfY4Y3WtdB_netU08@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=UTF-8;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sebastian Pipping <webmaster@hartwork.org>,
	=?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Matthieu@a-pb-sasl-sd.pobox.com, Matthieu.Moy@gr.pobox.com
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 09 11:58:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pn7kh-00026B-6w
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 11:58:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754440Ab1BIK6V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Feb 2011 05:58:21 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:55721 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754306Ab1BIK6U convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Feb 2011 05:58:20 -0500
Received: by iwn9 with SMTP id 9so964iwn.19
        for <git@vger.kernel.org>; Wed, 09 Feb 2011 02:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        bh=jZPsQ/dUg2AZVrerkX9qBQm+GH/XeMCRUnX4ZbKkboQ=;
        b=Ez6edeUoVFvB8y0dboqiVC2if4CmjMapMd3fCj6ltLj2CCoQHMmv74hKC7M6x8+S8U
         MecsbJHAXgTgfRq3xnNY9m3E0RK1hp1ul+8dnYkhhlHapsgvsmgPQXOkGZlECl8nsz0M
         oNrKbb/BspwtGi6TqkaVYOfw6Pv2RQ078eo7k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=klt2xEzOaaXHpmOWFgiHggCzXwE4MuieJlchAu+5+QdZY2qOvaZWfAfwgtrhb2GcfZ
         R4VUuBD8VH5RVLiobjv3D0Qsl4Wzg/BJZa8jxVZpZq5IJZ6f99y+bOkRhmXm+WjaeKsI
         kQ1PRyXZvmiJ5tR8jtiC7JUJh5/JpmkKRSQJk=
Received: by 10.42.218.5 with SMTP id ho5mr21640638icb.403.1297249100145;
        Wed, 09 Feb 2011 02:58:20 -0800 (PST)
Received: from zaphod.jjuran.dyndns.org (c-71-227-175-60.hsd1.wa.comcast.net [71.227.175.60])
        by mx.google.com with ESMTPS id u5sm154927ics.6.2011.02.09.02.58.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 09 Feb 2011 02:58:17 -0800 (PST)
In-Reply-To: <AANLkTimG6s5vSCnisJCt-EXkcJGXfY4Y3WtdB_netU08@mail.gmail.com>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166401>

On Feb 6, 2011, at 10:14 PM, Nguyen Thai Ngoc Duy wrote:

> On Mon, Feb 7, 2011 at 12:58 PM, Junio C Hamano <gitster@pobox.com> =20
> wrote:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> write=
s:
>>
>>> When -u was introduced in dfdac5d (git-add -u: match the index with
>>> working tree., 2007-04-20), "add -u" (without pathspec) added
>>> everything. Shortly after, 2ed2c22 (git-add -u paths... now works =20
>>> from
>>> subdirectory, 2007-08-16) broke it while fixing something related.
>>
>> As long as the command takes pathspecs, it should never be tree-wide=
=2E
>> Making it tree-wide when there is no pathspec is even worse.
>
> git log -p and diff family all can take pathspecs. All default to
> tree-wide without pathspecs. This is what I'm doing all the time:
>
> git diff
> # checking, ok, looks good
> git add -u
> # ack, need to come to root dir first

The only reason I'm not routinely bitten by this is that I'm generally =
=20
always at the root of the tree.  But I certainly *think* about it as =20
an operation that's tree-wide, not local.  If I meant to limit the =20
scope, I'd specify a path.

Josh
