Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28740394795
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 12:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773662930; cv=pass; b=BHV7ETlyPuYuIps1RzNULqytudIP2guGDYAMMKba79O1o5FeaQ/tFs4GuQi2fU8S+SoSmt4UxmI4A8Pt7KXL+/BhaWBb4XNHr0NmOIS1En8AIDuFxQEBqpM1/ngWk78qvL/o+46GVJwMQsbFwWU1DSgufaf+i7iNgHjZXkLsVhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773662930; c=relaxed/simple;
	bh=btDy0NvHrU3QI3NUfb5UpzwPM8Bn/oAxTJYOApOIsoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ViFoy67F5Qu2lFARgEPlQI6ZF89jDa8MWLCKQCGgCeoBZPdSwAnUz2+7ZJH3X8nSf7mkLOFnuLs0uVRLOwtmT5zMDyLD7LsKFWjNaBpq7ASiNI+ND1XKIWFWLVJaMPQcra7x55HWS9vtWOHrt3aSPDnjQdx+EJfQ2hIeCkqkYrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bv6hurKv; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bv6hurKv"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-128ef4dddbfso1489495c88.0
        for <git@vger.kernel.org>; Mon, 16 Mar 2026 05:08:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773662928; cv=none;
        d=google.com; s=arc-20240605;
        b=kWXlmImotsL3imb7v4Eg+QzyyDdpr1U4i43qcJc+RDW/aWwpWlj/5sgaACfsgIlIJ/
         tPizgoIao21sNu+apWs2g5eFaMQbgHXcTsYCxQ62lIe5wDKYpR58hocAcN8tIJ0JskeX
         WOO0jhakhtRjB443n3DQobrc4/tDeO0cJG2BFh7DVIv8TdcHHeqabs+Bo0yDac96tybC
         eyLfajFTNzQGqO4n8DnNp9Ya6hZ2ENtNYgPhets7N4gA0PudYEwInuoVr5g7rAoaLY5H
         GR1IeAZPvQ0K19fRDltGk8ol2rGPDoFuIQrReAUt/DAV+giM/vv77NGG7sl0M9Yvyeff
         d4Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+WiDaaRgESH+bH82mGjFTokVc4vYRweQ9MAc/+HS02c=;
        fh=8mRAhMgRrlmUCid4VoYvAABqOLjH6YUN61F75yj3F6Y=;
        b=CEzLWjYpiYEmCA46kohmt7rl13JaDGRkAQ5xglwRofI3V0607Icu9J4IDqMNdoNlEd
         62rt6FkmNwH5UUrXHpHudvTJikgeoVxDewJ9FHcqeCQbEIhtO14mG14GGqC6kThPjCAx
         BCW70UfCeNrWDGCWtYpeZuOXEM8ZVW1WqWTmw/T/4/yZBoY/jU+STSqYW9w83VC+JuDY
         AdsuZILuVhCa9qYKBu0el4HCu0zawW6lMN1gvxlqpjqpgCJIJlBmM1pWITSeuh0JvsQh
         HLvGj2AcGgUuqVta8vaZc3bwFY0OqtNFYKcHd/lmFqVebNQzeJMTWYH891oEg/yiijfd
         YLlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773662928; x=1774267728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+WiDaaRgESH+bH82mGjFTokVc4vYRweQ9MAc/+HS02c=;
        b=bv6hurKv0weuztVV+95Eb/Ihitmuao7iSvoREd9KaLsHnHWzDxTElvcP1ixrYc72/F
         d+Z6HYrItnWjPqrocuSdzi/lJqJcWghOU8DucpS7SQ99CpzhH0FtOWIZ9CFxMvGcXu5w
         5fEM3rgZaNScnTnw3v0ttMHv1ZhI3S5LfeVlS50A7MgLJi6DpGS6gHUzB8G9EYrKJTrj
         aFzhg4SVKqZ1UPna44zDum8x595z67ILG4k+lGq4FaBtO1Wpb787B7WWn5g/pZFS/FEu
         k54/LBeaFd7iQKcYXt6arRlz7svxjypXTfqHzzO37d6Os+tfP8lZAFwk0lTbrUyENJUf
         JNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773662928; x=1774267728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+WiDaaRgESH+bH82mGjFTokVc4vYRweQ9MAc/+HS02c=;
        b=PDRQ0Ew03FBDZYh5tW/3joQZC0Jmdd5Bx6fLGf7PBw9Bp+2et/f36jFZvAUFRqJTSj
         loCF5UTCNhwdkVANrxg45xbJyKiGf0CWDlMdR8r0eDBbgxKFyuSxD04JrofN/XrRs3qo
         On3xO/X/964Bdpj5z/cidVYRzNpiWyIWC5TIm7djlG9gdgSHF+k98W5ZcjxpTELIzh0L
         FDjYQVy44KgkFgLv6iGlAsAJtN933NlqNebdPogCZT2HvPNkUR7emsrWgzZu3W0c2xEO
         2yLxKvRLCn8WyCW9qCqLdfJq6q3wMQkCY096uiZW+7TFLggsJGYaDts5jPE2y/Kl2IMs
         xenw==
X-Gm-Message-State: AOJu0YwOJuhOqZ7LzSaolDhekUpUAuPY6MYtT7s/iQGmFgUmHZ9u/3vF
	Mam7VOfWcw0b8Crg1mUJre1ZQVKjqWEZ1D7KcytY7/Hf/Yb+tyfLHx3V13Su0r2M9UKfKfbibyF
	x07UczFlz65/Xf8CNJCoX+E6/fCE8VmI=
X-Gm-Gg: ATEYQzwdhmUnHg0X2nsVEP611t01f+QJGUew1dod+KTWikWBkW+RxPQ3KlNyXZRGHEo
	8zDGGJzwcqzcRNknOC/5twkIbhoJcJJih9su7FNreD5A2fYOBqdb82j+X1lhV3AzMW9Y9qdduLw
	GIcJEYwu1lN6fYtJ2pVyvnUCytBnnhuSiWOp1BSXLN170UftxGHo2EG1VXB2Sv5C14QYoFIFhGb
	cCymvrWk5ULaH6xdjmcpJ8/t30cHDobx2d3eOZW3AALOshaQ6xsTTDh5ILt/HatxmV6FjCc9Lxj
	UkIceXZwZEs69Q5PPhzd+Ll1uQRZPsidk4/DE1QkW56wXwWjYOmFRJ0w5CIaFc3mvzUS
X-Received: by 2002:a05:7022:2214:b0:124:4d0d:6921 with SMTP id
 a92af1059eb24-128ecba47e8mr6722793c88.6.1773662928120; Mon, 16 Mar 2026
 05:08:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305204809.54927-1-valusoutrik@gmail.com>
In-Reply-To: <20260305204809.54927-1-valusoutrik@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 16 Mar 2026 13:08:36 +0100
X-Gm-Features: AaiRm51s4rwsMRAzzNADEiBBHlX5MZKa8okyTZTW4qL0lHYwbGpeNdPMTUmQnZ0
Message-ID: <CAP8UFD3LJEU1YNBOi5VtpZANTY9PA3_v=eU9JF163F2efp-hGg@mail.gmail.com>
Subject: Re: [GSOC Proposal] Complete and extend the remote-object-info
 command for git cat-file
To: SoutrikDas <valusoutrik@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com, jltobler@gmail.com, 
	ayu.chandekar@gmail.com, siddharthasthana31@gmail.com, 
	chandrapratap3519@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Sorry for the late feedback.

On Thu, Mar 5, 2026 at 9:48=E2=80=AFPM SoutrikDas <valusoutrik@gmail.com> w=
rote:

> I have read through most of Eric Ju's [4] work and some of Calvin Wan's [=
5]
> work. I am still finding more things to understand from each thread, but
> I feel I have grasped the basics.
>
> My work in this project would be focused on implementing the changes
> suggested at the end of Eric Ju's [Patch v11].
>
> I wouldn't say I understand every bit of discussion from that thread,
> but in general my understanding is :
>
> Calvin Wan and Eric Ju has already implemented a client side command

s/has/have/

> called get_remote_info but its designed for being batched to reduce

s/its/it's/

> multiple network trips to get a single object's data.

The `git cat-file` command has a `--batch-command[=3D<format>]` option
to enter a command mode. In this command mode some special commands
and arguments can be passed via stdin to `git cat-file` to request
information.

[...]

> ## Project : Complete and extend the remote-object-info command for git c=
at-file
>
> Currently in the case of a partial clone, the user cannot retrieve all
> object data without fetching the object beforehand. To solve this problem
> Calvin Wan and Eric Ju had designed a patch sreies that can solve that,

s/sreies/series/

> by utilising protocolv2 servers capabilities.
>
> This was done in the form of "remote-object-info".
>
> But only the %(objectsize) was implemented, and that patch was not merged=
.
> This project has two goals
>
> 1: To Rebase and finalize Calvin Wan and Eric Ju's Work by addressing
>     the feedback on Eric Ju's Patch v11
>
> 2: To add support for objecttype in remote-object-info
>
> 3: To discuss other information type like objectsize:disk and deltabase.

s/type/types/

But anyway I think "information type" is not a good wording for these
things, because we already talk about "type" for Git object types.
Please try to find a better wording.

> ## Timeline
>
> Mar 6-31 : Refine Proposal
>
>     If possible I would like to submit small patches... but first I will
>     have to rebase Eric Ju's Patches ... I am not sure if I can do this
>     before GSOC...

You can try a rebase to see which issues would need to be resolved to
complete a rebase, and talk a bit about these issues in your proposal,
but otherwise applicants shouldn't start working on a project before
they have been accepted.

>     If not, I plan to contribute to git in other areas.
>
> May 1-24 : Community Bonding
>     1-7  : Understand relevant underlying/ helper functions
>     8-24 : Ask about any design related problems/decisions
>
> May 25 - Jun 14 : Start a Patch Series to rebase Calvin Wan and Eric Ju's=
 work
>     and keep refining
>
> Jun 15 - Aug 15 : Start and keep refining Patch Series to add support for
>     object type information

Would you implement both the client and the server side in the same
patch series or do it separately?

> Aug 16 - Aug 24 : Discuss and Implement other object information if possi=
ble
>     Concurrently I shall make a report for all the work done.
>
> ## Availability
>
> My current semester is ending in the first week of April, so I will be
> able to contribute 7-8 hours per day, totalling around 35-40 hrs a week
> on the project.

Do you have another semester starting after the current one?

> Total weeks =3D 12 , total hours =3D 35*12 =3D 420
> It leaves with a lot more room to accomodate any unforeseen circumstances
> that may arise during the project.
>
> ## RFC
>
> I have a few ideas but do not know if they are worth pursuing, so I will
> leave them here in the first draft
>
> - Addition of a remote-object-info outside of batchmode :
>     Yes it should be optimally used in batch mode .. but if user wants
>     only one objects size or type then should they be able to just
>     `git cat-file -r origin <oid>`
>     and get the size and type ? or something similar , I am not sure if
>     the way I have depicted it conforms to git's design.

Not sure if that would be very useful first. Also that might be better
in a different command than `cat-file`.

> - Addition of commands for common user behaviour :
>     I dont know if its going to be a common user behaviour but what about
>     `git cat-file -r --all-absent`
>     Or inside "git cat-file --batch-command=3D"<format> remote-object-inf=
o
>     --all-absent --type=3Dtree <remote>"
>     which would basically fill in remote-object-info with all the blobs
>     that are currently absent from the worktree ?

There are other ways to do this, like using:

git rev-list --objects --all --missing=3Dprint

Thanks for your proposal.

Best.
