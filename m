Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqgfXiym"
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF005DF
	for <git@vger.kernel.org>; Mon,  4 Dec 2023 04:21:06 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1d03fb57b69so16054715ad.1
        for <git@vger.kernel.org>; Mon, 04 Dec 2023 04:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701692466; x=1702297266; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SWztG6Wzg9S0jxBvLvveG85AhHqb6eWtzGKJfWp2VKM=;
        b=KqgfXiymf9UDnzohe+XP93LO+W678vj0gcBTfaXQ5+ZGzFv/YERZKYKgy2q05KBw9H
         5LWJoWJ+gMmn4mTaMsZ2Q8RwC29M3TOyZ7tBXJRJ7l74WN5hvP8tYXXQaIpQVCy9m4mh
         iorIabkqAaQCtosbAbVRfnWx1Q0crd9rEQhe2BgzJ6P+S482RaFxZ6iAwPe/EGvlHqUK
         LBkm2cmaEG155wrX1E1hTquBxa4fUS9uy2drp7kSfX9pUz3Xj4wZz5Csgh2e/DIZizHo
         n//wmRljX+O9tlA5ka9r3Ah5Vy1vNkWc1c4GFv7JuwFyxBTKIbuE/NS/liVnc5jsqGN+
         1tXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701692466; x=1702297266;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SWztG6Wzg9S0jxBvLvveG85AhHqb6eWtzGKJfWp2VKM=;
        b=C9HJNNAR2Y93SKs3t4jgAZZJWxYvi496drO07fCgbJdlJLJzHpY7zKtKOJ3/eRIJZS
         kOUCoFGMVv5GtM+/tV+ggpuwy+z0GDRzRCPkL9n9PuXJsRuZRKM3qkgayHSA1JbwoHuy
         atnF3vPCGEA4HpIX8OHp7fFpNI3T/2VFOx5L+MXCyhPBN9y5HFXB9LGhSipFHMXcpVzv
         vQClWiNlh10f+2bGbEvZJ0jCVX08M/lgDxuMYOr5kakcQ7EVPM4EpgA9mRCcfLz0rI3c
         VB/l3A/P2d0qCGrbHRhih5J5d11J8P+TOm0he40kkRAf3fUpOtQmHtMnoqXyduJ5FdS/
         jM0A==
X-Gm-Message-State: AOJu0Yx2ekBbLws+EDwJ0GVytq2bXUWb8ljwu+8My55xuY2grbNEWWMB
	e4NAlKjcQkjr4iuyUfL0XU74YStxAHVi9KUaQwz9OW/K
X-Google-Smtp-Source: AGHT+IHPP8TqPAyhkkXPoZQU403ju8lduqXRs/q39xNVtugrm9zN1KeJ4kG8dzpD0pt9Z3wxxDgQKZROsmBNzz6vyH4=
X-Received: by 2002:a17:90b:4a10:b0:286:6cc0:8854 with SMTP id
 kk16-20020a17090b4a1000b002866cc08854mr1535093pjb.65.1701692466218; Mon, 04
 Dec 2023 04:21:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGX9RpFMCVLQV7RbK2u9AabusvkZD+RZNv_UD=R00cSUrjutBg@mail.gmail.com>
 <xmqqjzq9cl70.fsf@gitster.g> <xmqqv89tau3r.fsf@gitster.g> <xmqqpm01au0w.fsf_-_@gitster.g>
 <bf848477-b4dd-49d3-8e4b-de0fc3948570@gmail.com> <xmqqwmu42ccb.fsf@gitster.g> <b3532261-3cf4-4666-9cbd-4ce668cd2e49@gmail.com>
In-Reply-To: <b3532261-3cf4-4666-9cbd-4ce668cd2e49@gmail.com>
From: Willem Verstraeten <willem.verstraeten@gmail.com>
Date: Mon, 4 Dec 2023 13:20:54 +0100
Message-ID: <CAGX9RpH0RJfBADQwJ=c7PCHU955vOqd0Wdc7Yi7XUuAQQW_FNQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] checkout: forbid "-B <branch>" from touching a branch
 used elsewhere
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

It's not clear for me from the email thread what the status is of this
bug report, and whether there is still something expected from me.

Is the current consensus that this is a real issue that needs fixing?
If so, does the current patch-set fix the issue, and how does the fix
get into (one of) the next release(s)?

Do I still need to do something?

Kind regards,
Willem

On Thu, 30 Nov 2023 at 16:22, Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Junio
>
> On 27/11/2023 01:51, Junio C Hamano wrote:
> > Phillip Wood <phillip.wood123@gmail.com> writes:
> >
> >> At the moment this is academic as neither of the test scripts changed
> >> by this patch are leak free and so I don't think we need to worry
> >> about it but it raises an interesting question about how we should
> >> handle memory leaks when dying. Leaving the leak when dying means that
> >> a test script that tests an expected failure will never be leak free
> >> but using UNLEAK() would mean we miss a leak being introduced in the
> >> successful case should the call to "free()" ever be removed.
> >
> > Is there a leak here?  The piece of memory is pointed at by an on-stack
> > variable full_ref when leak sanitizer starts scanning the heap and
> > the stack just before the process exits due to die, so I do not see
> > a reason to worry about this particular variable over all the other
> > on stack variables we accumulated before the control reached this
> > point of the code.
>
> Oh, good point. I was thinking "we exit without calling free() so it is
> leaked" but as you say the leak checker (thankfully) does not consider
> it a leak as there is still a reference to the allocation on the stack.
>
> Sorry for the noise
>
> Phillip
>
> > Are you worried about optimizing compilers that behave more cleverly
> > than their own good to somehow lose the on-stack reference to
> > full_ref while calling die_if_switching_to_a_branch_in_use()?  We
> > might need to squelch them with UNLEAK() but that does not mean we
> > have to remove the free() we see above, and I suspect a more
> > productive use of our time to solve that issue is ensure that our
> > leak-sanitizing build will not triger such an unwanted optimization
> > anyway.
> >
> > Thanks.
