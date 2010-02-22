From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] submodules: ensure clean environment when operating in a 
	submodule
Date: Mon, 22 Feb 2010 23:56:39 +0100
Message-ID: <cb7bb73a1002221456q6c113675i7453e0115814c99c@mail.gmail.com>
References: <20100218203726.GD12660@book.hvoigt.net> <1266877015-7943-1-git-send-email-giuseppe.bilotta@gmail.com> 
	<7vljek51t1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	msysGit Mailinglist <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 23:57:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjhDD-0000pS-0a
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 23:57:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754758Ab0BVW5G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Feb 2010 17:57:06 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:46267 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754643Ab0BVW5F convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Feb 2010 17:57:05 -0500
Received: by ewy28 with SMTP id 28so3373060ewy.28
        for <git@vger.kernel.org>; Mon, 22 Feb 2010 14:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=C0x19bKXLfWiPPPxoDNo+Zi6heXBhUh5UnPbmCbUkXg=;
        b=FD8ny8pGCLMmhbbj776o02Gk952TDZMCi7Pr7rE282PgDMTGtDgLzAunZxB8QS5zF2
         vJfzfTQFwPUew1dfijavoMx/nG5I833o+r8eEbvjjwOYGTbAfJGpqqUfFUXyK03qe9oL
         NkiNRaatMDlmFCQNiYwP+I3Auh79d2JCTn/4I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=CJdVHPsX1Q8K9JoYjsuSL4CG4FVu0r7jOKAw2HZJH+lAZpdivJN2Y9Y/oulswUl4X+
         elp989p6WQZaX5YFlTtAyPpSjX469wKHmjMKh6DZ28m6xBzMWWiii49d771RZ5IPJk5Z
         o472EWf0midBJkIfdMQig4U8OAa0K5mcABWig=
Received: by 10.213.58.138 with SMTP id g10mr1682009ebh.85.1266879419277; Mon, 
	22 Feb 2010 14:56:59 -0800 (PST)
In-Reply-To: <7vljek51t1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140735>

On Mon, Feb 22, 2010 at 11:43 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>
>> I'm pretty confident fixing this on the submodules side is the more =
correct
>> approach, since otherwise even a simple
>> $ GIT_WORK_TREE=3D. git submodule update
>> on the command-line can fail.
>
> True; while I didn't bother to check what the codepaths after these
> unsetting do, I suspect you should also think about what effect it ha=
s to
> have other GIT_* environment variables seep through to them (GIT_INDE=
X_FILE,
> GIT_CONFIG and GIT_OBJECT_DIRECTORY come to mind). =A0You would proba=
bly
> want to have a single shell helper function to unset even if you end =
up
> deciding that it is sufficient to clear GIT_DIR and GIT_WORK_TREE and
> nothing else.

Good point. All GIT_* env variables should be resent when descending
into a submodule. Is there a way to loop over them, or do I have to do
something horrible like env | grep ^GIT_ | cut -f1 -d=3D  to get the
list?


--=20
Giuseppe "Oblomov" Bilotta
