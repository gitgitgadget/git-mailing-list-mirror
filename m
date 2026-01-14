Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A444378D86
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 07:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768376455; cv=none; b=V6M/LVF13aEtEAVNHMXKZMSyxCynR9B9+Y9+R2vcYpe9sTDBvtAunmiXVZipe1iNqvZsb8NOcAe3Z3y/W3+w2l6dqqjgbGtiNcN1u20+1GsPK6W1uj7hb+gzF+DwKlQys3/z//uzCaMCy2Nt1YG7MX4/1VhK5QK2QphYUBbuJMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768376455; c=relaxed/simple;
	bh=GpuVT8U1BnvNSJtwexak8EYvoVwo7PPtlEFZ9+8pF1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MgkmG14gvtmM0+FbcxISd32aFzwz7ZY8LdahBHuZbnsxTuD0jJealEGcjn//7qSn2JKvA5M5EoGVmdQ3Pq3SFL7FQc8YRbb24d9jvS84YJgjoqilj2wmkr3X50PcepF6uLh0lCdBaH7P37A0NXM4ben0AP1FX02lgNrXpXQcQnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROScI/Ap; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROScI/Ap"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-11f1fb91996so208980c88.1
        for <git@vger.kernel.org>; Tue, 13 Jan 2026 23:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768376451; x=1768981251; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RTq0GVI8ISuGjddgsVy4jD0lYVSTta2c53C9iUeXpRc=;
        b=ROScI/ApQDgcA4oovm62GyOYWPwNIugPJCR1RHGNYn7heam8CaawVX3WZ++JnHSZFz
         lN8NssR7048/TuQiAXptvXdr5i3Yhu7Vf4L7lZJPsk/i8YiTvV9o6WFsUZpRzvfPElY9
         Yl+5aLYWgH5PrHyaVNh0X8p0puyLt4jUrYVBLM2CM3sR+zJQpO7TYUd7+yaC77dNsD1N
         bpTTYLcJxyOoySZ6gaewVFXKgrT21qpjvhDJpZuD5Regk0LQDRy6cwlDpSFKMKOuWIVu
         7HzfWO68r/evODIhnjbVYQSZz1wNmidaiWZSVQD7Z/tn0woNlvLOrAMjV7N2mzNePb7l
         Cx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768376451; x=1768981251;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTq0GVI8ISuGjddgsVy4jD0lYVSTta2c53C9iUeXpRc=;
        b=nkbQ6f0d9uPnL6/al1zJ9FroYXVe2T/FkQTAWmDqdAtzyYRFjqWSBQnMG6OKL3lT1F
         14+oCXmjhWgO1ra/u0XsEZBUqtWivpBGWmcFWDHxBm79FD/3wUrlo//9GAPynKH79cKW
         r1qU3cdP9T2n467SllGex8IpfPxxLMlSYOOdRX+7rrnbVNUYjwy2IpJNytHjAlV4wo7Z
         uU754BawHKoLH5boSr5xbe+eLj8KUUD0Mc2S/1+ceHAdMcOw4WH9yjm3jLTyO1opF51F
         D60Uqkr3aSlv4T1jQZxv4+16Dqj6t5ZLVD9BKJF6bEXabfYk0McktUJWd11MbACl2D4l
         s4PA==
X-Gm-Message-State: AOJu0YzbPflC/tX9/aS3IyVRLojsOfIoGiZImQLpysaVSWdr0Hbu+Gd4
	0O8xJQ+HLdT1d410V09NpIDnL6Q6PSos/9DvcP0PzNDqPJKuuiTQy+NIgTU3FCXKJn9nvAsO8SF
	y9/WlA7lV75+IkPS2GUOR4u9y1RPn7rE=
X-Gm-Gg: AY/fxX4zYK4G1QKVtNa4fysa6O3RwAijv01UT106IjNf9KIdXgeXxJrCiCo90rD4Fy7
	o/oykqfqRICmNCUJB+eTtQ5Ib+B9iuv7QyCuppauxnjgsboi/K/eauaJmVioQOZ+QnEWlkyrbKr
	t7R89F3rVGWiu0ArbnUaRRBe7v1SjIz5v48KBFzfe8QZI9g55WRozUubY7de9WAsWMkxevSt/Sn
	XYw9YADuhfUfJRO+7CQFNSpXxg4DRhaM7w6VZc7PCkSVVFqGMvp6G9Xb5gfzY7kAMqeE5I9o+Q=
X-Received: by 2002:a05:7022:698d:b0:11a:4016:44a5 with SMTP id
 a92af1059eb24-12336aacea2mr1888987c88.24.1768376450871; Tue, 13 Jan 2026
 23:40:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1768318762.git.belkid98@gmail.com> <6e54e22ac7096f26e774acc4740bcb135496fb69.1768318762.git.belkid98@gmail.com>
 <xmqqo6mxi91e.fsf@gitster.g>
In-Reply-To: <xmqqo6mxi91e.fsf@gitster.g>
From: Bello Olamide <belkid98@gmail.com>
Date: Wed, 14 Jan 2026 08:40:52 +0100
X-Gm-Features: AZwV_QjyuhEQtFkREQnptuUW0lrMrRKkf-1LzWBNbweJpH7oFANrhC0sDJhuTu4
Message-ID: <CAD=f0L-mPX+KECUjXk-WBzEbTP7wCa8sB56GySQT0yh9mfUOWw@mail.gmail.com>
Subject: Re: [Outreachy PATCH v2 3/3] environment: move "branch.autoSetupMerge"
 into `struct repo_config_values`
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, phillip.wood123@gmail.com, christian.couder@gmail.com, 
	usmanakinyemi202@gmail.com, kaartic.sivaraam@gmail.com, me@ttaylorr.com, 
	karthik.188@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 Jan 2026 at 20:53, Junio C Hamano <gitster@pobox.com> wrote:
>
> Olamide Caleb Bello <belkid98@gmail.com> writes:
>
> > The config value `brach.autoSetupMerge` is parsed in
> > `git_default_branch_config()` and stored in the global variable
> > `git_branch_track`. This global variable can cause unexpected behaviours
> > when multiple Git repos run in the the same process.
> >
> > Move this value into `struct repo_config_values` which holds all values
> > parsed by `git_default_config()` and can be accessed per
> > repo via `git_default_config()`. This would retain the same
> > behaviours while achieving repository scoped access.
> >
> > Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
> > Mentored-by: Christian Couder <christian.couder@gmail.com>
> > Mentored-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> > Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
> > ---
>
> Currently the code flow is for git_config(git_default_config) to be
> called fairly early in the program, updating the singleton globals
> that are independent from individual repository.  This moves these
> global variables to be stored in the config_values structure that is
> tied to the_repository.

This will move those global variables that are repository dependent into the
struct repo_config_values.
I admit the mistake is from my end. I should have been clear on that in the
commit message rather than say '...holds all variables parsed by
git_default_config()'.

Sorry
>
> The claim in the cover letter was that this will make it possible
> for us to later work on more than one repositories at once and each
> repository can keep its own independent value.  While the updated
> data structure may make it _possible_, I am not sure if this is a
> safe approach to get to the final state, without seeing how the
> config_values structure in the second "repo" structure is populated.
>
> And before moving all these globals into config_values, it is not
> possible to safely populate the config_values structure in the
> second "repo" structure, if git_config(git_default_config) is what
> we plan to use.  The settings that are still stored in globals will
> then get overwritten.

The idea proposed by Phillip is that we pass the repository parameter
as the call back to `git_default_config()`.
But since that will be quite invasive, you proposed we use `the_repository`
for now. Then later we can pass the repository parameter as the call back
and handle the invasiveness by simply checking in git_default_config()
struct repository *r =  cb ? cb : the_repository

>
> That is why my first question for this round of patches was "are all
> these settings inherently per repository?", because the scheme would
> not work if there are globals that cannot be moved to config_value
> structure to be per-repo.

The movement does not target all the global variables, but only those
that are dependent on a repository.

>
>
> > diff --git a/repository.c b/repository.c
> > index c7e75215ac..d308cd78bf 100644
> > --- a/repository.c
> > +++ b/repository.c
> > @@ -57,6 +57,7 @@ void initialize_repository(struct repository *repo)
> >       ALLOC_ARRAY(repo->index, 1);
> >       index_state_init(repo->index, repo);
> >       repo->check_deprecated_config = true;
> > +     repo_config_values_init(&repo->config_values);
>
> Having a call to repo_config_values_init() when initializing an
> in-core repository instance is a reasonable design, and I see this
> step has an initialization of git_branch_track in that function.
> Shouldn't we be doing similar initialization in the same
> config_values_init() function for other members of the structure,
> namely, attributes_file_path and sparse_checkout?

I opted to initialize only the git_branch_track because in the original code,
it is set to a default value BRANCH_TRACK_REMOTE before the call to
git_default_config()
But attributes_file_path and sparse_checkout were only declared and
not initialized
before the call to 'git_default_config'.

I just tried to replicate the current behaviour be initializing
git_branch_track and those default
values early before the call to `git_default_config`

>
> The function also may be a good place to do an equivalent of calling
> git_config(git_default_config) there to grab values that are suitable
> for the given repository, but I didn't think things through.
>

Thanks
