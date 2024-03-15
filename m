Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AAE2E62D
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 13:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710508989; cv=none; b=VX1Ctf0pRzyw7K6alAEP2gnE+fJIDtxx7l5Zg2NTGBOoJ9/aZ5rvQtUbKyI1kNPIHQYDBxElbi/XV7Vnr/2UEM6+uY0HOUwNzCMeKfwslLorV02Ac0oSbY+HUdVFI29D6cJwDAA6qr0Ss0mIzl6+lWD/+JChC36EjFziggoaAg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710508989; c=relaxed/simple;
	bh=DdI1s910jWzEkZFUrwrSex3YDx5NntYNXDOTJAG3EyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=icnMZaZZFiyI8H1FYMEbbQcnah92nkbJQyupKRV716uxwHTVKQZM3kc46pztnziH71RSZTZtNxJVtMrTctumPV1hsmx8Ev7Zkf1UG+1IGPLhwE06N3YaD0Nw01lSmfwG08z4yOql9TGpRaI/RZ5FLTTPIsRFUIIPdME2TEl3+KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=HTJVizCH; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="HTJVizCH"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a468004667aso136347366b.2
        for <git@vger.kernel.org>; Fri, 15 Mar 2024 06:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1710508986; x=1711113786; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GnjaceCHwf+ZkVKWHR0Xysf4NKaquuqGtfSAHO3VnSo=;
        b=HTJVizCHMM9p8iyU6qxKSXw3HGm14fS5eqJsa09X86a/ypeTzN4QnpiFk39WR9ttYf
         JidjgdhKao01CUERCgF2Z+iMhr1A85k6yiX7nE0cL9o7KxLI0guDUH/6FODKZwDTUyxP
         FnluoRvOTOt+HrrsaiyquL8JSZA/0FXAATstzjNTD8183/NteyJ5KlgxYZcnxUzG4tk8
         7zNLov/otkLNxIceujzKtw4VwG9+r1416kb/lSfkpaDov1l0OrrbWV2yyCHPtNcB7y8E
         LwqoAPFfEcvB+HOxnWxUSyJiyNbybohCyO8fVtRGopFRqgbWi7+9KIrgkwhTrf7OBNav
         PxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710508986; x=1711113786;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GnjaceCHwf+ZkVKWHR0Xysf4NKaquuqGtfSAHO3VnSo=;
        b=uZslltzuhK4SdzFaeJRG6GrNkq/PdPZbDawWQ0VO6Lwcr+LeUNk8bQT+qY0ZGqBqCc
         8qaostIEN45Ya5YKvzG/UkhAexwDYiCgY94ypwT/ewn+TUexK19XssxutyipmkjMVa4u
         SvfaIC9wg2mYF70Q52OszbuaHCtUOpvW62DimoBgAy29mmviEBBCXiw6+pLBoJCMoW57
         +qE1EfO6TnOZQtvszssYb0kV1/JxoNpvuVMUnflq5xOx/RtpRYuLtqwDz3GJWvOZSsAO
         tgsaOLfYLjQbWnxyjFWXV73uH/hJLRI05GTlaXYwInWPeL4ZPcc6QagmdaQzUh5/lFwu
         w+gQ==
X-Gm-Message-State: AOJu0YzHn9nlkHR57/b7qOHVYIqkm2youKkhx6NY5D7oeVApU65Wjklj
	v3V6z676uTcafYpZCvYOoIFrbNqh8U1USmqk+wCuHvvq7ATiTwByzxMwSH3PTYbGRLu2/hI4be2
	up9Ii6sUhaAhAjhCUQWH2y1ks6SIKivVH8tLvXA==
X-Google-Smtp-Source: AGHT+IEA2rgIG7VjsTUpjnpkP5/uQKnF8sTjfYn7JBteIehK0uqK3iCZ5jufRmtwkKY+0EJye5TF6gM9F1q2277XbCM=
X-Received: by 2002:a17:907:1909:b0:a46:716d:7f7f with SMTP id
 ll9-20020a170907190900b00a46716d7f7fmr4063964ejc.24.1710508985608; Fri, 15
 Mar 2024 06:23:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+XMOBuK1_BNqgQRfCne8dVXKGPt+iQ9wt4iZqz0PgEqZ5UCtg@mail.gmail.com>
 <606fe3fa-a5a0-4d35-a4a0-59521043dde4@kdbg.org>
In-Reply-To: <606fe3fa-a5a0-4d35-a4a0-59521043dde4@kdbg.org>
From: Kai <k.vongrambusch@googlemail.com>
Date: Fri, 15 Mar 2024 15:22:52 +0200
Message-ID: <CA+XMOBskofgsmCbcchmPYo9rF9+Cdtdj_m8VzQrLbGhZPm+mrw@mail.gmail.com>
Subject: Re: Git is not recognizing some merge conflicts and just accepting
 incoming master version
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Hannes,

Thank you for having a look. Below my responses and further information:

On Fri, 15 Mar 2024 at 09:24, Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 14.03.24 um 11:30 schrieb Kai:
> > I am encountering strange behavior when trying to merge master into a
> > feature branch. Trying with guis VScode and Gitkraken, both are not
> > displaying all conflicts in the files correctly and are just accepting
> > some changes from master which are conflicts and break the code.
> >
> > I am including two example files as well as screenshots.
>
> No files were included in this message. Don't post screenshots when the
> content can also be represented as text.
>
> That said, a conflict needs three files, not two: the base version,
> their version, and our version. But better than file attachments would
> be to just paste the relevant parts into the message (if you know what
> the relevant parts are and that other parts are not relevant).

Ok, I was assuming that having the whole files may be better to
reproduce the problem, but if just the relevant parts are enough, let
me do that.

Here is an example from all three files:

### BASE FILE (I used git merge-base master hook-form to show the
ancestor commit)
export const AddListingForm = (active: number) => {


  const form = useForm({

    defaultValues: {
      city: { name: '', lat: 0, lon: 0 },
      neighborhood: { name: '', lat: 0, lon: 0, neighborhood: '' },



### MASTER BRANCH (THEIR VERSION):
export const AddListingForm = (active: number) => {
  const form = useForm({
    name: "add-listing-form",
    initialValues: {
      city: { name: "", lat: 0, lon: 0 },
      neighborhood: { name: "", lat: 0, lon: 0, neighborhood: "" },



### HOOK-FORM BRANCH (OUR VERSION):
export const AddListingForm = (active: number) => {


  const form = useForm({

    defaultValues: {
      city: { name: '', lat: 0, lon: 0 },
      neighborhood: { name: '', lat: 0, lon: 0, neighborhood: '' },


### GIT DIFF MASTER TO BASE FILE (git diff
12545fa846fb0d042a4ed29ee0699d89f1621bc2 master --
components/add-listing/forms/AddListingForm.ts)
   const form = useForm({
-
-    defaultValues: {
-      city: { name: '', lat: 0, lon: 0 },
-      neighborhood: { name: '', lat: 0, lon: 0, neighborhood: '' },
+    name: "add-listing-form",
+    initialValues: {

### GIT DIFF BASE FILE TO HOOK-FORM (git diff
12545fa846fb0d042a4ed29ee0699d89f1621bc2 hook-form --
components/add-listing/forms/AddListingForm.ts)
No diff in relevant part


So as you can see, in this case Master has changes to the base file at
the relevant part, while in the hook form branch we continued to use
the base file version of that part. Now maybe I misunderstand how
merge conflicts are supposed to work, but shouldn't I expect git
marking the changes master made as a conflict? Because in master parts
of the file were changed that I did not change in the new branch? When
I now merge, the code is not working, because masters code is applied
and it breaks other parts of the code in the same file.

If this is expected behavior, this is a big issue in this case, as I
cannot trust that after sorting all conflicts that my code will work.
In that case I would need to manually review every diff. Or is there
maybe a stricter mode for merge conflicts, to also highlight these
types of differences?

>
> > In the first example, the conflict of the UseFormReturn type changing
> > between the two versions of the file is not being recognized.
> >
> > In the second example the useForm hook is completely different between
> > master and the feature branch called hook-form, but no conflict is
> > displayed.
>
> These descriptions sound like the conflicts are of semantic kind. Git
> can't help in such cases. Git can only detect textual conflicts, that
> is, when both sides modify the same or adjacent lines of code in
> different ways.
>
> -- Hannes
>
