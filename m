From: Jeenu V <jeenuv@gmail.com>
Subject: Re: git notes and core.editor config
Date: Tue, 11 Jan 2011 16:44:21 +0530
Message-ID: <AANLkTik-=s-F8dmBRLU8o9LcSztb1P0WnkN5HK_n_No4@mail.gmail.com>
References: <AANLkTi=0BrBV+DLF_QfDi0mMVdz5tCLFsDMBKvw52nzz@mail.gmail.com> <201101111131.17429.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Jan 11 12:15:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PccBn-0005XJ-9K
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 12:14:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755829Ab1AKLOy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Jan 2011 06:14:54 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:40320 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755634Ab1AKLOx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jan 2011 06:14:53 -0500
Received: by wwa36 with SMTP id 36so1631807wwa.1
        for <git@vger.kernel.org>; Tue, 11 Jan 2011 03:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=5waZ5Aa37P4p7zxTmQuAsFtqtxnMrFQvo6ElYYM3GVM=;
        b=YSUWKQyywUlT7L6+QOhoRlyQBMZu6RFeLz6KzYle32TSXYQmaHDdbVYV8c7Y9Mm9Cu
         8C98IfVHg+EKjIRBOVe3mJviSzVJMN+9wXRvG6Qff/1BUL09KhMDD8j0P85/1zjgPe53
         JSayikQ1rNf+jBKqWbtXvC4hHjLX0K13E55wg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=eSZa5T0uHI8sIQT5tDrCrUoAR2qLuMn30knjaKLkImSFWKJapl/UbXDa2R0lOH4eKP
         aNUeR1Ed/nd1N/ZU+fMIh4tLl3pBwtJ+biqcvOeY53ZAJRxXNV9+FBbyUkYTKQRxOGki
         1iAiYlL5I+hcd0nsUHa9+MqOYgeiOYwRxYUhM=
Received: by 10.216.187.82 with SMTP id x60mr867357wem.9.1294744491700; Tue,
 11 Jan 2011 03:14:51 -0800 (PST)
Received: by 10.216.254.166 with HTTP; Tue, 11 Jan 2011 03:14:21 -0800 (PST)
In-Reply-To: <201101111131.17429.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164928>

On Tue, Jan 11, 2011 at 4:01 PM, Johan Herland <johan@herland.net> wrot=
e:
> On Tuesday 11 January 2011, Jeenu V wrote:
>> My core.editor value in $HOME/.gitconfig is set to
>>
>> =A0 [core]
>> =A0 =A0 =A0 editor =3D vi "+set tw=3D72 spell"
>>
>> so that I've text width of 72 with spell check turned on. I haven't
>> found problems with any git commands that invoke editor, but notes.
>> 'git notes' seems to invoke the vi for me with 3 separate arguments
>> instead of just one: "+set, tw=3D72, and spell". In other words, I
>> don't think it honors shell quoting for editor config variable.
>>
>> Could this be a bug?
>
> Indeed, it could, but I cannot immediately see what causes it. In
> current 'master', builtin/notes.c launches the editor like this:
>
> =A0if (launch_editor(path, &(msg->buf), NULL)) ...
>
> while builtin/commit.c lauches the editor like this:
>
> =A0if (launch_editor(git_path(commit_editmsg), NULL, env)) ...
>
> In both cases, the details of interpreting core.editor is left to
> git_default_core_config(), and passed to launch_editor() using the
> editor_program global variable. AFAICS there is no difference between
> how "notes" and "commit" interprets core.editor.
>
> What Git version are you running?

$ git --version
git version 1.7.0.4

--=20
Jeenu
