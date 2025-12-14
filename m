Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B8B265623
	for <git@vger.kernel.org>; Sun, 14 Dec 2025 18:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765736703; cv=none; b=ky49n2WW76+vYSRu8V4lZXCWGwGD4Q53AGjMPPQj6ZlgJ3X5K3Ecni26Z8HGITp3k/m8uZiUzaILr1qk1ESMhLOfUKNoPq6sKUqKPhVgiDoDck/ldlguK5eaT8EhRKrqVGvoiVVyaJdDoz1ZPR8wlokqmftQ3uByu3XTcxLqxbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765736703; c=relaxed/simple;
	bh=h12ISjS0Xg27wS64snCwXQp3Tlb3q87LJiSw0sS8baA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sgier9gAM4ds+QvdaR9c9MC03wmZLXGV7aL27BzksCUgXdyq2uWcSVim0c9lcOmZjEhh3ovBWlWO25Uu+nWk0KDtmnwp04acBLWu4ZguYT2578SuouyloIMyqAzT8IPGHDtoK9vaUATktuLMCx5Hrdv099MJVPLFGU1mQpdAXJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8078zLo; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8078zLo"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64464de1c45so2810592d50.2
        for <git@vger.kernel.org>; Sun, 14 Dec 2025 10:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765736700; x=1766341500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TuAQPLUSZ3+VSUKeXDxPvsUvNNE1ZJMqRxyNlR1GlTY=;
        b=J8078zLowKMtl+wUXT/vlnwWMYdTIFiI3Y/5rTbSIdb+EmpnUxBXF1EEoSTkGC3qvI
         /AY57o5fQTjKAIvLedDKvF4lupAdVjS5w3on5rqJBHzzguRHqwGyT6p+/sS/YxTMUMaK
         dau+/zLHgrb988kif8SJ0EAQMUwtmx8lHZ9WAwgKuO3K568SiV2hi6wYVVulYlt5v1dt
         u7maqlgJdX2SH2gK974RT9FJ6R4LINT59p1Qp3loc0qpHJvpyI5kpYqILe9kBBj1N348
         n1RVy5DqszxUOcNV7t2lvIXA4rchLTqvx2N9ODM9CBEQAWLZgnuUVUHBP+HMCny5N3ig
         OsQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765736700; x=1766341500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TuAQPLUSZ3+VSUKeXDxPvsUvNNE1ZJMqRxyNlR1GlTY=;
        b=Khk2HZ6k4KMluCr8Nl+zXY3xMH2sbp4CZNhVgppWO6e2UF2bEXsTKRWeiXgJlVYXgD
         F0Pkgj/RDuNP4Xic2hm2XSwUzi5QVEtJLcffm0z4MC8f8wsGEtDyb9CXJ9n+wzIdHuhY
         gJpkgVUDeUFrXZuhYl9Smuc8rrUoyViqhTUAlTrTnw4jkrp+H0M3Wi4T+eeRUPminOwi
         6pxZTBYOodYLiUcVUZdXWF7uUzb0xwG7vs3kg4jsOVkwTo7Ft9WF0J+NRkxH6wTO5AGn
         2ibxbzfKtkaBtLKWls0vHUaBxD+Ywtg5VbsEd0cMUx+Itv3kycO+XbCtDkFM+NHm7E2Y
         72YA==
X-Forwarded-Encrypted: i=1; AJvYcCVdNgDQw6IqsVYkzU8uNI+UsRvd3jpws92IKT3Er0+7OZzUc4gzFVmQNpNbLg1ufCQpaJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRqijiv7riGJUGXtg8VgN9CAiX7mS5ocnNHXPGel2s77Q5/rHv
	ugcbbI4Iptx7hCie10Gd5m0dy7AiB/AhnOGvwh9dWIvErFZwpT/7cQ57vq8D7Z9RVjigXdEIS2Y
	EIHUR/Mu3zuxQ7oAXTWZV8d2N71em5I8=
X-Gm-Gg: AY/fxX460fFuvbFgXbdn0Na+HK1U3oFMZY8EvYv9Li+sP+pUFLToPagYeu4dSj1ENBe
	GrLt1+9G6Odysi4fnkU5i6dFLpmTbtCf0Ygoj+DV2o4b7hisXnsie54YOObJHtro5p10f7zdv00
	v0p+r6k0NRcp9YaLEnXogbL6I1WygIc96ZMRnciwUFKC902ya1kBCVI+ZqDnvkZZIjLZqPlvXft
	Vjqzr6oiCS/0PkN+eMxF+bjDslHDWXn6rRAepYGV3C0md65lAT/mfJFO+LfWoMfRfpDZ3TWdDOj
	xq1fCw==
X-Google-Smtp-Source: AGHT+IF/A/NCCXYbr4rTXKqs1aT87DG/QcCSsU5m5Juc/qR3uYYgnUberRojjzO8dxfqmF1ZnxBYio1mcpyV6dcIfGw=
X-Received: by 2002:a05:690e:1187:b0:63f:31f7:b956 with SMTP id
 956f58d0204a3-645555e8e2cmr6427288d50.27.1765736700223; Sun, 14 Dec 2025
 10:25:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118201842.1447666-1-jim.cromie@gmail.com>
 <76038c97-39ca-4672-adc0-4e8fe0e39fc8@akamai.com> <CAJfuBxxFWD0rEjm-va+Bjmf-m2nfOD_+ZEqKy22WX6QdugQCUw@mail.gmail.com>
 <5b3d492c-7037-45a5-a001-0064f14d5f81@akamai.com>
In-Reply-To: <5b3d492c-7037-45a5-a001-0064f14d5f81@akamai.com>
From: jim.cromie@gmail.com
Date: Mon, 15 Dec 2025 07:24:34 +1300
X-Gm-Features: AQt7F2qR7epCcPZPFyfS31ZMn7q415nXmBzUWk-f7hwRotzggU7ovP6q9koFi7U
Message-ID: <CAJfuBxzW6TMmdS74ZPfPSe1w6S=oO17WYZc-Jgn_et=-Muw05A@mail.gmail.com>
Subject: Re: [PATCH v6 00/31] drm/dyndbg: Fix dynamic debug classmap regression
To: Jason Baron <jbaron@akamai.com>, git@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	gregkh@linuxfoundation.org, ukaszb@chromium.org, louis.chauvet@bootlin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

for some reason I cannot grasp,
git am fails to process this mbox.

It entirely misses 13/31,
then fails to apply 14, which needs 13

Im able to cherry-pick 13,
but then I cannot --continue with 14,
even after bumping .git/rebase-apply/next (iirc)

jimc@frodo:~/projects/lx/linux.git$ git am --empty=3Ddrop
~/Downloads/PATCH-v6-00-31-drm-dyndbg-Fix-dynamic-debug-classmap-regression=
.mbox
Skipping: drm/dyndbg: Fix dynamic debug classmap regression
Applying: dyndbg: factor ddebug_match_desc out from ddebug_change
Applying: dyndbg: add stub macro for DECLARE_DYNDBG_CLASSMAP
Applying: docs/dyndbg: update examples \012 to \n
Applying: test-dyndbg: fixup CLASSMAP usage error
Applying: dyndbg: reword "class unknown," to "class:_UNKNOWN_"
Applying: docs/dyndbg: explain flags parse 1st
Applying: dyndbg: make ddebug_class_param union members same size
Applying: dyndbg: drop NUM_TYPE_ARRAY
Applying: dyndbg: tweak pr_fmt to avoid expansion conflicts
Applying: dyndbg: reduce verbose/debug clutter
Applying: dyndbg: refactor param_set_dyndbg_classes and below
Applying: dyndbg: tighten fn-sig of ddebug_apply_class_bitmap
Applying: dyndbg: macrofy a 2-index for-loop pattern
error: patch failed: lib/dynamic_debug.c:155
error: lib/dynamic_debug.c: patch does not apply
Patch failed at 0014 dyndbg: macrofy a 2-index for-loop pattern
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort=
".
hint: Disable this message with "git config set advice.mergeConflict false"
jimc@frodo:~/projects/lx/linux.git$ git help am

IOW 1st below fails cuz 2nd was missed.

9d3217b82474 dyndbg: macrofy a 2-index for-loop pattern
0181185c3e75 dyndbg: replace classmap list with a vector
ef6ee2b321ce dyndbg: tighten fn-sig of ddebug_apply_class_bitmap
804e6a0d59b6 dyndbg: refactor param_set_dyndbg_classes and below
039806bc83dd dyndbg: reduce verbose/debug clutter
162a0398fae9 dyndbg: tweak pr_fmt to avoid expansion conflicts
d5524fc1ef31 dyndbg: drop NUM_TYPE_ARRAY
a6e1e7f4da90 dyndbg: make ddebug_class_param union members same size
a1d3e32dd906 dyndbg: reword "class unknown," to "class:_UNKNOWN_"
5692e955f0ce test-dyndbg: fixup CLASSMAP usage error
3ee7e303e78e docs/dyndbg: explain flags parse 1st
2f33390837fb docs/dyndbg: update examples \012 to \n
256317aa5996 dyndbg: add stub macro for DECLARE_DYNDBG_CLASSMAP
37bad039f6c7 dyndbg: factor ddebug_match_desc out from ddebug_change
7d0a66e4bb90 (tag: v6.18, master) Linux 6.18

On Sat, Dec 13, 2025 at 4:57=E2=80=AFAM Jason Baron <jbaron@akamai.com> wro=
te:
>
>
>
> On 12/10/25 4:12 PM, jim.cromie@gmail.com wrote:
> > !-------------------------------------------------------------------|
> >    This Message Is From an External Sender
> >    This message came from outside your organization.
> > |-------------------------------------------------------------------!
> >
> > On Thu, Dec 11, 2025 at 8:09=E2=80=AFAM Jason Baron <jbaron@akamai.com>=
 wrote:
> >>
> >>
> >>
> >> On 11/18/25 3:18 PM, Jim Cromie wrote:
> >>> !-------------------------------------------------------------------|
> >>>     This Message Is From an External Sender
> >>>     This message came from outside your organization.
> >>> |-------------------------------------------------------------------!
> >>>
> >>> hello all,
> >>>
> >>> commit aad0214f3026 ("dyndbg: add DECLARE_DYNDBG_CLASSMAP macro")
> >>>
> >>> added dyndbg's "classmaps" feature, which brought dyndbg's 0-off-cost
> >>> debug to DRM.  Dyndbg wired to /sys/module/drm/parameters/debug,
> >>> mapped its bits to classes named "DRM_UT_*", and effected the callsit=
e
> >>> enablements only on updates to the sys-node (and underlying >control)=
.
> >>>
> >>> Sadly, it hit a CI failure, resulting in:
> >>> commit bb2ff6c27bc9 ("drm: Disable dynamic debug as broken")
> >>>
> >>> The regression was that drivers, when modprobed, did not get the
> >>> drm.debug=3D0xff turn-on action, because that had already been done f=
or
> >>> drm.ko itself.
> >>>
> >>> The core design bug is in the DECLARE_DYNDBG_CLASSMAP macro.  Its use
> >>> in both drm.ko (ie core) and all drivers.ko meant that they couldn't
> >>> fundamentally distinguish their respective roles.  They each
> >>> "re-defined" the classmap separately, breaking K&R-101.
> >>>
> >>> My ad-hoc test scripting helped to hide the error from me, by 1st
> >>> testing various combos of boot-time module.dyndbg=3D... and
> >>> drm.debug=3D... configurations, and then inadvertently relying upon
> >>> those initializations.
> >>>
> >>> This series addresses both failings:
> >>>
> >>> It replaces DECLARE_DYNDBG_CLASSMAP with
> >>>
> >>> - `DYNAMIC_DEBUG_CLASSMAP_DEFINE`: Used by core modules (e.g.,
> >>>     `drm.ko`) to define their classmaps.  Based upon DECLARE, it expo=
rts
> >>>     the classmap so USE can use it.
> >>>
> >>> - `DYNAMIC_DEBUG_CLASSMAP_USE`: this lets other "subsystem" users
> >>>     create a linkage to the classmap defined elsewhere (ie drm.ko).
> >>>     These users can then find their "parent" and apply its settings.
> >>>
> >>> It adds a selftest script, and a 2nd "sub-module" to recapitulate
> >>> DRM's multi-module "subsystem" use-case, including the specific
> >>> failure scenario.
> >>>
> >>> It also adds minor parsing enhancements, allowing easier construction
> >>> of multi-part debug configurations.  These enhancements are used to
> >>> test classmaps in particular, but are not otherwize required.
> >>>
> >>> Thank you for your review.
> >>>
> >>> P.S. Id also like to "tease" some other work:
> >>>
> >>> 1. patchset to send pr_debugs to tracefs on +T flag
> >>>
> >>>      allows 63 "private" tracebufs, 1 "common" one (at 0)
> >>>      "drm.debug_2trace=3D0x1ff" is possible
> >>>      from Lukas Bartoski
> >>>
> >>> 2. patchset to save 40% of DATA_DATA footprint
> >>>
> >>>      move (modname,filename,function) to struct _ddebug_site
> >>>      save their descriptor intervals to 3 maple-trees
> >>>      3 accessors fetch on descriptor, from trees
> >>>      move __dyndbg_sites __section to INIT_DATA
> >>>
> >>> 3. patchset to cache dynamic-prefixes
> >>>      should hide 2.s cost increase.
> >>>
> >>>
> >>
> >> Hi Jim,
> >>
> >> I just wanted to confirm my understanding that the class names here ar=
e
> >> 'global'. That is if say two different modules both used say the name
> >> "core" in their DYNAMIC_DEBUG_CLASSMAP_DEFINE() name array, then if th=
e
> >> user did: echo "class core +p > control", then that would enable all t=
he
> >> sites that had the class name "core" in both modules. One could add th=
e
> >> "module" modifier to the request if needed.
> >>
> >> One could prepend the module name to the class names to make them uniq=
ue
> >> but it's not much different from adding a separate 'module blah' in th=
e
> >> request. So probably fine as is, but maybe worth calling out in the do=
cs
> >> a bit?
> >>
> >
> > Yes. that is correct. class CORE is global.
> > If 2 different DEFINE()s give that classname,
> > the defining modules will both respond to `class CORE +p > control`
> > but they will get independent int values (which could be the same, but
> > dont have to be)
> >
> > DRM is our case in point.
> > I reused DRM_UT_CORE...
> > because I didnt have a good reason to change it
> > that said, Daniel Vetter noted that the _UT_ part doesnt have a real re=
ason.
> > So theres some space for a discussion, when I resend that patchset.
> >
> > `module drm class DRM_UT_CORE +p > control`
> > will narrow the query and avoid all the drivers/helpers,
> > which could be what someone wants.
> > class DRM_UT_CORE would select drivers and helpers too,
> > so the DRM_UT_  disambiguation is appropriate.
> >
> > I'll reread the docs to see if theres a bit more I can add to further
> > explain this.
> > Do you have any suggestions for wording to achieve this ?
> >
>
>
> Ok, so sounds like DRM_ prefix is already adding some scoping vs. just
> the simple 'CORE' name. So maybe just something like:
>
> Note that class names exist in a 'global' namespace. Thus, if two
> different modules share a common class name such as 'core' both modules
> will have sites enabled via: echo 'class core +p > control'. Thus, you
> may wish to scope any new class names to a specific use-case or module.
> For example, drm uses the 'DRM_' prefix, as in 'DRM_CORE'.
>
> Thanks,
>
> -Jason
