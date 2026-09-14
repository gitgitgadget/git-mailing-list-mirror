Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2178A48986B
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 13:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789391041; cv=pass; b=lfKArl9aoQf6XumcCnvgs6CGPweF9gNqYpqkJfRsm4LW8CXF51B1LIj/T6e9NCDdgxkVDDh8pX1hmPfczBiT9q7nhCDUNXUD0VnH4hJM2gsk2yvxV0iNHHiF0ASE4WTYG+cXXprc+UKfkRYc6jXohpxPdHmi6ZdZoKc81qq9yD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789391041; c=relaxed/simple;
	bh=6o0fstGK/kVfEoLXEqroH9K6Y22dO7kq804uuZYckrc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UAbaM7sg4JpniccGSJl16XD4K+9RN32AYaPuGX1E5rRMkzA/lsa2KiS7ROUpurs2CM70wIOyXRJGrj7FlbaNbVhkW9hmJ6MgwGZxK7l6KuANxezllmBVj0TunwCPI/pOmtLjhZ2MBibCfFkZdMsXmOHmGlJvVXAAktA6FXPzAUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJLPa6V5; arc=pass smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJLPa6V5"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c537df4daaso601573b6e.1
        for <git@vger.kernel.org>; Mon, 14 Sep 2026 06:03:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789391038; cv=none;
        d=google.com; s=arc-20260327;
        b=bp8O/CCySmIrFskx/6WW29PspEtCKP2o9jOhKjq0XqyKxZa/sYl8QVbCaFkwOAIoTg
         6/16orIj4UPKoIE1AxmLUKIUwd6NrCwt6SKpSsepzdOykT+xe9TYzHJkG/CR9UstkHIQ
         mGhE21HLTiXNr+nI11/lKq8PKz9eMYFis+kjohU+wR6zB8Ki7gHN59d9JLClQFl6oaPA
         HkmrBFJZWCFLvipFtg1rL93W+bT9ICB+87UvYqqoXFNmopqLojHE4oUKVQ+379xC7mod
         zVJefo+u0dL+umWaciBq0sPK5Xa6ccXRwwB7QcyqQtHxdi6MLXakOLCA0m/+/nPTHMNM
         QzbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YtrYPwg5tOitYudFjuo4/2dTd3cR3GlDih1BJgjmMuE=;
        fh=7SnmKOQODkq4e20rl3LLSfm6mhdBKxnqqO99/bzjX3U=;
        b=UKYWLo0JIHf0ry1lkmW2VrOrKtE5zyZsQI7H0vg7Y196IeawbZFqIhlN61iK54joQZ
         dFzZafsoCWXUEGn4Cacc+OYwOCQ76ixhcFcFRUahtooSQ7m4kPtwSj+4c1jbJfTBdQRK
         mOxiXOiFUgG53Eo4Q59VIouxfTOR/6RSVwslu6IVxJTd4tihh5h38cfjmk0DGilhO/Sb
         mdJffgy2mAHBS25S8jyisMIKaUc++vRtPeziYn6owwNypAZ09obhJSddYK22UcCCl3vg
         TKiN+p+ze2THwQNev7GESGwKcVsVHfnm2q4pK8Yb/F79ZzRk0BGMlL4mL9XY2VrDghfO
         HDqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789391038; x=1789995838; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YtrYPwg5tOitYudFjuo4/2dTd3cR3GlDih1BJgjmMuE=;
        b=FJLPa6V5jYz/Mbaucd7ULavJp83mLRRy+7Cd6JdhsDrogs9za7UWT5aPL5PTMWzuiD
         9akY/TPsLVQc1E9Xh94DbpkOewxCdMRX4OjttUaTRnQdiHhVIfQubbM4ttEAHo3RplZE
         3JVWLlJ5eTvT5EW+pXnKGea7PS8WR5Z6/9X008vounHC1xEmLhjhiND/+REHz1Cz5SXe
         GzozL4HcIVJWSYWImCv8RXkfyAzwsI9J29f4f9IU9JD5TrZNbDS2Wjiw8xuC5ZTCZdCn
         GPh/bmQUHBzJ592ZUMCBbk2hrIbCfohPRFQDzIOSRUJFoLp7W/ej+r17NjNgGS7yKDAO
         UO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789391038; x=1789995838;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YtrYPwg5tOitYudFjuo4/2dTd3cR3GlDih1BJgjmMuE=;
        b=sQ4GO3m3lNSdKa/2h9NB4pAlEXwLxRoKJpjhCU/n3GFJyzCg9Y3kooYQLGhc5ZHbvv
         UQMtwxPvgyUNhnU3u2x72CycG396yqD1R4NaxLWY+uJAEe8aJJB/fz6NBoZM38N0FFqf
         MVt3NgoCp+8ZhIXfyilmGlkrjlRAmKRmUHbUQxub8L7r+q5kZ6hl2e+SNIE/RfSke37K
         kk0Xel4OAGbQeETFz3byMdsKvs1OdeYT6OC1hki6DkvHl8KF6mIWq4zNqmzQcmwTTfJM
         h60XybA+ne4gEMYaFPRwlxlgn4fnzGwH0yqG8vAl7iUw6eAfNeHwWiQd9Q/yU1NpS+fI
         F1ng==
X-Gm-Message-State: AFuF++n0CVTzQ2LA/aAbGtb4j3aEQs6OlhYXBgI7+tPPex27gx8wvqnd
	dq61ZTiPzzbPdqAeiDlIPKgdRErgN4EUP9jZVJnoa+eIobPfylyQR+ly31NYCGXTBg5jVUuBf7a
	X1+9T7hJ7/sw3F0h/ZKK1pBUO9wDb70k=
X-Gm-Gg: AYBFou2fwm6xZuClxKALmPlVCEheH6tIdeKWDek9FpfDHj+xKaUrXVOtBrzFemaFJHo
	DrTrnWBEXEIPMP+Akce9iqZKfxYrkmoDhzUjlarYzYcVpo0Ks20vUJgPWXff2YnxSRGuwAoXY11
	vDc+WMwRKvsiaAZAUpDo06R1udFV0y27zLSYhFQy+XGYU3Ip6is9nrBjJu+xNd93OdBU9QRjIIt
	+lsNUqYfTFkl/1Mp9e4yRr8I4YbOWTUwMUcYL2105Pv80B7ESSCbkcQpp9bnHuUXm4b0oifBRLc
	IQctdQpJESD2SYCZySY4F90O19eQZoa+oXH6VtF3lQencylPukHfhMw2tmOSJy5hPaGxTCD2sj7
	EvyiZX60cb/XJbzwyNtQQirqXXtPneKReXyb+HxbKu+4IryjhrAgMIEOUxgpssmr3c9u7eUy05L
	Oc00lGVk4=
X-Received: by 2002:a05:6808:6d97:b0:4c3:ebb:6405 with SMTP id
 5614622812f47-4c7b579ee74mr1305824b6e.32.1789391037663; Mon, 14 Sep 2026
 06:03:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904210122.431757-1-tyler@tylercipriani.com> <20260914040018.76111-1-tyler@tylercipriani.com>
In-Reply-To: <20260914040018.76111-1-tyler@tylercipriani.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 14 Sep 2026 09:03:46 -0400
X-Gm-Features: AcwNN1WChOxAWGXh4vpkyDHuyrnQrO8C0yca2b6KU0-iDUsUeBwARFDfTf0sf4o
Message-ID: <CALnO6CDz8QBcBojmhjgwgWzi4oUbs+V4KVQ1h0+JgN7k0v-SYQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] push: check pushed ref for --force-if-includes
To: Tyler Cipriani <tyler@tylercipriani.com>
Cc: git@vger.kernel.org, Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>, 
	Stefan Haller <lists@haller-berlin.de>, Phillip Wood <phillip.wood123@gmail.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tyler,

On Mon, Sep 14, 2026 at 12:00=E2=80=AFAM Tyler Cipriani <tyler@tylerciprian=
i.com> wrote:
>
> Changes since v3:
>
> - check_if_includes_upstream unconditionally resolves peer_ref with
>   RESOLVE_REF_READING, now all non-branch ref pushes will be rejected
>   when using --force-if-includes
> - add test for --force-if-includes tag push 1/2

This is intriguing and seems like a significant behavior change, let's read=
 on=E2=80=A6

> Range-diff against v3:
> 1:  da27c421ed ! 1:  e7912c3fd0 push: check pushed ref for --force-if-inc=
ludes
>     @@ Commit message
>     -    Find local reflog using ref->peer_ref. When using a refspec like
>     -    HEAD:refs/heads/main, we resolve HEAD. If HEAD is a branch, use =
that
>     -    branch's reflog.
>     +    Instead, use ref->peer_ref to locate a branch with a reflog. But=
 if ref
>     +    does not resolve to a branch (e.g., a detached HEAD, a tag, an o=
id),
>     +    then we reject the push. The alternative would be to use HEAD's =
reflog,
>     +    which is too broad to tell us if the history being pushed includ=
es the
>     +    tip of the remote. We need a per-branch reflog, which means that=
 pushes
>     +    of a ref that do not resolve to a branch are rejected. Rejecting=
 the
>     +    push of a ref like a detached HEAD already happens today (if the
>     +    same-named local branch lacks the remote tip); now the detached =
HEAD and
>     +    other non-branch pushes are explicitly rejected.

So, we would now reject a force-push whose source is anything but a branch =
(with
force-if-includes, and that presumably includes push.useForceIfIncludes)?

>     ++test_expect_success '"--force-if-includes" should reject forced upd=
ate from tag' '
>     ++  setup_src_dup_dst &&
>     ++  test_when_finished "rm -fr dst src dup" &&
>     ++  (
>     ++          cd src &&
>     ++          git fetch &&
>     ++          git switch main &&
>     ++          git reset --hard origin/main &&
>     ++          git switch -c newbranch origin/main &&
>     ++          git checkout HEAD^ &&
>     ++          git tag stable &&
>     ++          test_must_fail git push --force-if-includes --force-with-=
lease origin stable:main
>     ++  )
>     ++'

Which is what I think this test says.

I think this would break a common thing I do at work (although this is soon=
 to
be deprecated, so take my anecdote with appropriate salt; I can't claim tha=
t no
one else relies on it, of course):

As I think I described in the message you linked, I have an alias "pf =3D p=
ush
--force-with-lease" and push.useForceIfIncludes=3Dtrue in config. Our team =
has a
"main" release branch and a "hotfix" release branch for emergencies. When
hotfixing, we first reset the hotfix branch to the last tag to go out to ou=
r
production environment, which I typically do like this:

    # validate that we won't lose any interesting commits (no regressions) =
with
    # something like
    git log --oneline --graph --boundary --cherry-mark --left-right
origin/hotfix...<TAG>
    # push
    git pf origin <TAG>:hotfix

(On a second pass before sending, I can't recall if this works as-is when I
don't have a local hotfix branch tracking origin/hotfix.)

If I'm reading this version right, I would now have to say

    git pf --no-force-if-includes origin <TAG>:hotfix

or perhaps better

    git pf --no-force-if-includes --force-with-lease=3Dhotfix[:origin/hotfi=
x] =E2=80=A6

probably after seeing a (hopefully improved?) message after the original
command. (Do I need to disable force-if-includes in the more-specific lease
command?)

Now, on the one hand, enshrining existing behavior is good for backwards
compatibility but has earned us a bit of a reputation for not innovating in
useful ways ;) On the other, I wonder if the description of force-if-includ=
es
allows some latitude to break with existing behavior here.

The relevant docs say

       --force-if-includes, --no-force-if-includes
           Force an update only if the tip of the remote-tracking ref has b=
een
           integrated locally.

           This option enables a check that verifies if the tip of the
           remote-tracking ref is reachable from one of the "reflog" entrie=
s of
           the local branch based in it for a rewrite. The check ensures th=
at
           any updates from the remote have been incorporated locally by
           rejecting the forced update if that is not the case.

It is unclear to me what "one of the 'reflog' entries of the local branch b=
ased
in it" means! Ignoring that, the surrounding text only talks about whether =
the
remote-tracking ref's tip (or "updates from the remote") have been "integra=
ted
locally."

So I think we *could* say that, in this case, we don't have enough informat=
ion
from "<TAG>:hotfix" to check whether "origin/hotfix" has been integrated lo=
cally
or not, and we should tighten the meaning of the check. (Perhaps when
"--force-with-lease=3Dhotfix" is given, though, we now have more informatio=
n
available to check---but that could be outside the scope of this series if =
we
don't mind breaking backwards compatibility now.)

Thanks,
D. Ben Knoble
