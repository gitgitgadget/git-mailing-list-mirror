Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFB01B85C3
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 19:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725650973; cv=none; b=aQfWNH2tmIbi8exvyjMjFAfzLmH9h7A+VqIUvRCtnJ1sa2Ux8BicWA7mZMBL5W8bhkLfezfk4GZiSU+b3HxiTAcm+2u6l9NbuAjZEGYHbV4zjKzKfZYpyS3b/ToEs+Y4gK5mHtrY06tQOwfbau5GDqGzndPsROl/yrA4DNOc2RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725650973; c=relaxed/simple;
	bh=7uQW//z9iwGcKZu7bVKvM4dAKFFtdVcXc+hmjQ1WlIs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=nJXChDbj7xZDB0/RHFNkY9ATDLU/lK27iVKBcHX1EHTNuCgI5+3rexoqOHtmFqNkAn/iL87CIRk59vT1cfGKdKMXztNZ1Ah4z1OhYAKkrni6Gn1qa08+6p2815huk1J2h3tDcjTXYHI6h1BO/6O8mG0TFo08HJ9izZpZU2+PUe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xi09bUuT; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xi09bUuT"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-49bd2b37fe9so657813137.1
        for <git@vger.kernel.org>; Fri, 06 Sep 2024 12:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725650971; x=1726255771; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RIg4OjpDhnauPXnrMK/pokHQI6Yx9Fb66nCN8PzDWss=;
        b=Xi09bUuT1RcfY+toUOLGGlmAboEnC2SVXhO7OypPfd1Sv84v58o891In+S3iZ2knWV
         dW/Zokd5nHypfrN4eLFJJRLb5kVNmrjq7MJ9NaKBJvW6pLPmtG4mH/0bht8YFaoQE2yl
         2U5Ucyo0/2o8ZX4l7a/cSlvRuQeIzjjCyCvJKFVd92aYIhgiantM4z0OqATcHNd+6f3s
         hRjGERvxyCLy6FAAQU6V2PcEvOfh710IgnCclR+17T61M9Ylz2Hpgvqqf5OrQbBppq2s
         92/GyZCN39tnCaZbhoF5VGglDwGI6ieo/gRwQGv/MapG2tPX3k8+x00wVjoJQr2Lklmp
         B5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725650971; x=1726255771;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RIg4OjpDhnauPXnrMK/pokHQI6Yx9Fb66nCN8PzDWss=;
        b=fTQN2kwz0LbKkIntu9pJpXhtsZIWHiwS+M0ayj7Oh+0blL5yWGvx8x5dVXf94Ecn35
         EicGHEjpbBwOY7mf0UvvUDWHbSaSsZmnCVXpgvNqp9znZDr+aaJE6WUQwEgUlsTVvU0p
         NX1RiXSR9cS1Buey2TubTUF025NU/5pUMxsLGLME6o5qDDaVfGlJ3L96dwNBYX6Vnbgw
         uNoIzobQ4nl10PDeF+zq5Uoem8yx3hlZiXPD2QMupssPuHVonhO7DR4bHl33m/uPCyz1
         4c0IujljZreclMN1cPzeSb4zeYltPvvz3q4/UD3jfcuXxrIClPKTPqzheED3aFnk2b+3
         nm9Q==
X-Gm-Message-State: AOJu0YxPBafUfWcxwng1ba4Yn+9KSqDpfpmcqulA22EVGJmuvoNdaO9q
	h1E3PhJdbm2WdNLyhk5F+VnvSYtCIe3OiQphOp3yEJmh8sYzIGvaOHFbqvUGj4ZCNWgF4aEDlBp
	jgI0nWyNYpKJy8oZQcCaALDwQOhdRAt7WZkQ=
X-Google-Smtp-Source: AGHT+IFbA0d6y0LmblwnIlgfFPcsBD3RQFcPWErqL32E7OldLgafJ3K/z85GmoWQDNlUI+1o28YYZY0HPa0AMhwpMP8=
X-Received: by 2002:a05:6102:1291:b0:494:5a0b:716b with SMTP id
 ada2fe7eead31-49bde32801fmr3581227137.29.1725650970560; Fri, 06 Sep 2024
 12:29:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Stephen Morton <stephen.c.morton@gmail.com>
Date: Fri, 6 Sep 2024 15:29:18 -0400
Message-ID: <CAH8BJxEdvk5bajz0cN+6u9B-m=6ZcufsRNUhyaJ9hiHvgEq0HA@mail.gmail.com>
Subject: Possible git bug - repository remote becomes hamstrung if
 non-existent "remote.<remote>.fetch" refspec is supplied
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Summary:
A git repository can become blocked from any operations relating to a
specific remote if there is non-wildcard "remote.<remote>.fetch"
config value set for a ref that no longer exists on that remote.

(Perhaps this is not a "bug" per se. I don't want to cause conflict by
using an inflammatory term. But it is certainly something that
effectively "breaks" git operation and is not debuggable or solvable
by your typical end-user. I'm happy to call it something else, but I
wanted to report it.)

Minimal Reproducible Example:

$> git config --local --add remote.origin.fetch
"+refs/heads/foo/bar:refs/remotes/forks/foo/bar"
$> git fetch
fatal: couldn't find remote ref refs/heads/foo/bar
fatal: the remote end hung up unexpectedly

Observe how it is not clear from the error message where the problem is at all.

"git fetch --prune" does not fix it.
Once you realize what the problem is (which can take a long time), a
"git config --local --unset refs/remotes/forks/foo/bar" (in the
example above) is the only solution I've found. And the more generic
solution below seems a bit unwieldy

for fetchref in $(git config --get-all "remote.${remote}.fetch"); do
    ref="${fetchref#:*}" # everything after the colon
    [[ "$ref" =~ \*$ ]] && continue
    if ! git ls-remote --exit-code "${remote}" "$ref" &>/dev/null; then
        echo "Bad ref: $fetchref does not exist on ${remote}. Removing."
        git config --local --unset "remote.${remote}.fetch" "$ref"
    fi
done
