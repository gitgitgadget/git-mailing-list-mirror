From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 4/7] log: add --rename-notes to correct renames per commit
Date: Fri, 22 Jan 2016 08:00:40 +0700
Message-ID: <CACsJy8BZtr_2e-LyGpdQ52R1TBDL7x3ZZQPu+G3-tphBfrmAaw@mail.gmail.com>
References: <1453287968-26000-1-git-send-email-pclouds@gmail.com>
 <1453287968-26000-5-git-send-email-pclouds@gmail.com> <xmqqoacf3k3v.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 02:01:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMQ6G-0004RM-UH
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 02:01:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbcAVBBN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Jan 2016 20:01:13 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33026 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951AbcAVBBL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jan 2016 20:01:11 -0500
Received: by mail-lf0-f67.google.com with SMTP id z62so3250782lfd.0
        for <git@vger.kernel.org>; Thu, 21 Jan 2016 17:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=KKVa9WWI/Llv2Mi3IwLdcHXUMI/Rm9Qy3HClGAlNcyo=;
        b=lE2voKJn6NdpO04oRUHv0lXeMIvJcllyygoLRVQPQxLnr1v4r7lqfHRbB0V9L4ZotO
         BZUqwoFuBmXKAAGRS1zOKtp3F1ETc9h2lMZpsJjm8Q/w/UpAvGV+Y++oc6cPMDBmFkMt
         /QvFYp1ZQfhbuUNO8ZhkkgFRKEiQWn0HFcOZw7p3fpZjzOhbPN3XfyIVy7+jqFGeE0GQ
         B9uS9po9zNvxq1ZSoE9Sry7AnvBkzbiC/XINid6O5YtJ/oH8VDsez6EDwuLUcYJfUN80
         u+bYeF7Nfl7xcjWQ7Ro3EZd4BpDWefdfWC7zhv2OrmJYw18gZrEFV2leh9bfj3XTH0GT
         SCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=KKVa9WWI/Llv2Mi3IwLdcHXUMI/Rm9Qy3HClGAlNcyo=;
        b=P36qfWlfAnEiDKDrCYoP5ktpVG/wpJddAC/TrKumwuDA1ObZp/IrcCTF3iYtDGjcBe
         yJU2UfVuIEoz9Z1q+cTRNpFVbEtfoKl6a3RTZHnIWq239/bc+hCFd9ipDGZql4DipoTD
         fLbxA7wDAe1PlqOLqP/4hSY4SprKI8S2thbklBW50VoiTLBXdubMiFsGQQhCvG/kq1fp
         HPykquxCf10S/LMO+0vjTGyZOGGQvHZfNgucXRD0HBA+cWzHPftIQvsjIvD4j1koyzO+
         rIhYXoZFVMgDaj2bzZJn/rg9xTR/B0L+7WssrDf6AA6gwzSTC+oud3nhBF/kJKlydA7s
         d8VQ==
X-Gm-Message-State: AG10YORZjX7fqqGt9FE5O4h3JJMQdrSj6Gpwy86rcVN6diiQMBnJQ4jl/cn6cu12nW6yfxYEzaQx/yfcp2oTgg==
X-Received: by 10.25.157.135 with SMTP id g129mr95208lfe.45.1453424470090;
 Thu, 21 Jan 2016 17:01:10 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Thu, 21 Jan 2016 17:00:40 -0800 (PST)
In-Reply-To: <xmqqoacf3k3v.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284543>

On Thu, Jan 21, 2016 at 6:29 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> For simplicity, the note of commit A implies rename correction betwe=
en
>> A^ and A. If parents are manipulated (e.g. "git log --reflog") then
>> the rename output may surprise people.
>
> I do not think "git log --reflog" attempts to show changes to bring
> the tree of @{2} into the shape of @{1}, even though for traversal
> purposes it pretends as if @{1}'s parent is @{2}.  So I am not sure
> what you are trying to say in the above sentence.

Hazy memory about hierarchy manipulation by reflog, maybe I'm wrong.

> A path limited "git log -- path1/ path2/..." also manipulates the
> commit->parents for traversal purposes, but I think the patch is
> still produced against the true parents (there is a call to
> get_saved_parents() in log_tree_diff() that shows the change for a
> given commit), and in that context, commit A that has notes about
> the change to bring the tree of commit A^ to its tree still makes
> sense.
>
> I'd be more worried about "git log -m -p"--the diff against the
> second and subsequent parents would not want to use the notes that
> describes the change between the first parent and the resulting
> merge.

I "fix" this by providing the tools and let the user go wild. The line
"A =3D> B" says rename A to B for a diff between any source or target.
But they can also say rename A to B only if diff source is X, or diff
target is Y, or both. The syntax I'm having for that is something like
this

=2Esource X # X can be anything that resolves to a tree SHA-1 with get_=
sha1()
=2Etarget Y
A =3D> B
--=20
Duy
