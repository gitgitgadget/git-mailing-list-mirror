Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A6E35FF62
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 14:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770993308; cv=none; b=DLPlaTNawjZJ/uh3UkYAsdTQWaJJMZfERjctW7k5X0IOMwakE6ig9GvOMr3CqyJxfqjv7gOfV67VcrYVQ563Ry+HEWQuvr1m/gBMRU6/z++WFgv4Cmj9vi5S4jL6KlWmTCT5NwQxXz1Ve/OMcTgUl5JVjR9a2sFJc0nz0YEI5tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770993308; c=relaxed/simple;
	bh=UfJjuBu2ZuZTLvlJBzpkFxTOx3VXWsy8/GMlPHe8BXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aN1zJtli3axDnlrIQq+pLoK0GjmGUu6xKt3cqiIaLYlQf7uzBCgjTEaUUyW9oiezGJe8E2cezDPCkf8ClipiNqB9NkTHlQeadamZKr4n+wO8u33hD64npVDv9p/QmM/sq7kAUYR5X3jG6XXPzs2f4eX7kDVnA27/ufwxjUKPO/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GBZoRd5d; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBZoRd5d"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-483487335c2so9230215e9.2
        for <git@vger.kernel.org>; Fri, 13 Feb 2026 06:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770993305; x=1771598105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pdVAE4oKLO8hfJiiOG+CmxvW9//XINoAHE1qrbOjdP0=;
        b=GBZoRd5dXXBQ6KlZWuuwAKtktIq69HlsCEOfeBwfAb+vVp8GVfFe7KQGrOIrdo8z9z
         tI4EjqC2HZ9/RnUXzvjgpBbZo3R9PtkaSYNd6w/VCQVlOeQN/XC9hSd5y/1WLNmo6wwD
         FTRSImwb0C8LdWok/o/bdr3A2zXXZU+eRd1wP3VDuvb2TcbLMf98o3OJl3ySYVn8GEX8
         cpa/mjYwTl5ExnY05py0BnwtmH8OunkbcZSN21roDTtp6D3kehttqDEf1VHX95odMSqL
         H2PJ+M7PA5meqPFEjw5Qgw3q+tjBeEtX2bQJcBCRTNkmHNfdsZlyLNaYy6cgAR0kIJhQ
         rV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770993305; x=1771598105;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pdVAE4oKLO8hfJiiOG+CmxvW9//XINoAHE1qrbOjdP0=;
        b=oNvnnArMa24XwgNMA3K0q0vlEQ4QLPQkzeTQcAHFrg2arqiL2XyiwYHdqiHbj5hOLK
         VF81Gw87UJF+p6J2WYwdMTyWO8fxxRZtxSHCgCkcKYJv3LqTK4RrFZmeIsAZdEsQShvz
         OqkvTPSC9rmUZV5b1V4qCeP+vuME/bpN7oi6KhU2Zu4hbqlCnNILV3yTOP1HBYN6j22B
         Fgr8rFNQReS7RurnFqtc29QAN1+Vgz3SM+WVrhhXHtRnRSSfAM6EHI+n1G4UNWJ55zRW
         RJ5F1sPBTBqf4NMCMgKugDaGKiwExKWhToF751TcJmhe+VJzjrwH9VNOjdxD7sBxbozn
         oLZg==
X-Gm-Message-State: AOJu0Yyq/MXgdpND2qXT7FCwgfDiJktvrCokPuQihkmmWKOIUbp5WIbL
	RJf8Hvciktpe3M4M5TNDNRaebwZltZ0Kl1GhV45tcWOMl15tw9lg8NtrN1+SuorC
X-Gm-Gg: AZuq6aKTrrTO8VfJqZfB7/xIjBnq3Zt2A2Seu2odSVvNE81rzHk5ze66Rri+6SFBjbb
	8TeRjYZngOHLZmZ8mRxtTpUJ4RIBNfvwS+7BixRiHTENaJVvsVYHmL6I60xpmhib0l/KVj3iLng
	a+Oz72OjlSjV77az/GyBV997fE/GALnom/cpWuVEoXdiPLFAcGPiigWLHBQPPw/b28Wizwwus89
	4i2A2eTNSrfVHYry9DpWxOYCmN6epFY0FBBT2wWmYRr/6CyHmIPBEu+WcMSqmwiQIhjoI/orHl9
	1dtFe86Oeuk8jixwV7ujm3O28Yo5x086tKABuTmo9yWxODPNmy/fdQUUGXRZXRiyh5qtKXg6k5q
	3vLQz+wSAApW9o/4alAEZgOm+MxmkcsBUMh1yd4b5c0HgT4CeP7lU6McbkFe/AW+N3Zu1CVfetB
	qLoxQx6k/ALIFTjTKQlE3QTIQmvWw=
X-Received: by 2002:a05:600c:4e4d:b0:482:df17:bbbc with SMTP id 5b1f17b1804b1-48373a37b73mr32656255e9.20.1770993304184;
        Fri, 13 Feb 2026 06:35:04 -0800 (PST)
Received: from berwick ([2a0a:ef40:68d:f601:6840:9d65:3109:8533])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5e11f5sm257083905e9.4.2026.02.13.06.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 06:35:03 -0800 (PST)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org,
	Jeff King <peff@peff.net>
Cc: Matthias Beyer <mail@beyermatthias.de>,
	Jacob Keller <jacob.keller@gmail.com>,
	pyokagan@gmail.com,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/2] commit-msg.sample: reject messages that would confuse "git am"
Date: Fri, 13 Feb 2026 14:34:47 +0000
Message-ID: <cover.1770993281.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.52.0.362.g884e03848a9
In-Reply-To: <20260206090358.GA2761602@coredump.intra.peff.net>
References: <20260206090358.GA2761602@coredump.intra.peff.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This series adds a check to the sample commit-msg hook to reject commit
messages where the body of the message contains lines starting with
"diff -" and "Index: ". Such lines confuse "git am".

Changes since V1:

 - Allow subjects to start with "diff -" as they end up in an email
   header and so do not confuse "git am"

 - Allow "---" lines as they are useful when preparing patches.

Base-Commit: b2826b52eb7caff9f4ed6e85ec45e338bf02ad09
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Fsample-commit-msg-reject-diff%2Fv2
View-Changes-At: https://github.com/phillipwood/git/compare/b2826b52e...494f4df68
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/sample-commit-msg-reject-diff/v2


Phillip Wood (2):
  templates: add .gitattributes entry for sample hooks
  templates: detect commit messages containing diffs

 .editorconfig                     |  2 +-
 .gitattributes                    |  1 +
 templates/hooks/commit-msg.sample | 54 +++++++++++++++++++++++++++++--
 3 files changed, 54 insertions(+), 3 deletions(-)

Range-diff against v1:
1:  5f5e3091435 = 1:  5f5e3091435 templates: add .gitattributes entry for sample hooks
2:  e75978b9591 ! 2:  494f4df6865 templates: detect commit messages containing diffs
    @@ Metadata
      ## Commit message ##
         templates: detect commit messages containing diffs
     
    -    If a commit message contains a diff that is not indented then "git
    -    am" will treat that diff as part of the patch rather than as part
    -    of the commit message. This allows it to apply email messages that
    -    were created by adding a commit message in front of a regular diff
    +    If the body of a commit message contains a diff that is not indented
    +    then "git am" will treat that diff as part of the patch rather than
    +    as part of the commit message. This allows it to apply email messages
    +    that were created by adding a commit message in front of a regular diff
         without adding the "---" separator used by "git format-patch". This
         often surprises users [1-4] so add a check to the sample "commit-msg"
    -    hook to reject messages that would confuse "git am".
    -
    -    Detecting if the message contains a diff is complicated by the hook
    -    being passed the message before it is cleaned up so we need to ignore
    -    any diffs below the scissors line. There are also two possible
    -    config keys to check to find the comment character at the start
    -    of the scissors line.
    +    hook to reject messages that would confuse "git am". Even if a project
    +    does not use an email based workflow it is not uncommon for people
    +    to generate patches from it and apply them with "git am". Therefore
    +    it is still worth discouraging the creation of commit messages that
    +    would not be applied correctly.
    +
    +    A further source of confusion when applying patches with "git am" is
    +    the "---" separator that is added by "git format patch". If a commit
    +    message body contains that line then it will be truncated by "git am".
    +    As this is often used by patch authors to add some commentary that
    +    they do not want to end up in the commit message when the patch is
    +    applied, the hook does not complain about the presence of "---" lines
    +    in the message.
    +
    +    Detecting if the message contains a diff is complicated by the
    +    hook being passed the message before it is cleaned up so we need to
    +    ignore any diffs below the scissors line. There are also two possible
    +    config keys to check to find the comment character at the start of
    +    the scissors line. The first paragraph of the commit message becomes
    +    the email subject header which beings "Subject: " and so does not
    +    need to be checked. The trailing ".*" when matching commented lines
    +    ensures that if the comment string ends with a "$" it is not treated
    +    as an anchor.
     
         [1] https://lore.kernel.org/git/bcqvh7ahjjgzpgxwnr4kh3hfkksfruf54refyry3ha7qk7dldf@fij5calmscvm
         [2] https://lore.kernel.org/git/ca13705ae4817ffba16f97530637411b59c9eb19.camel@scientia.org/
    @@ templates/hooks/commit-msg.sample
     +			p
     +		}'
     +)"
    -+line="$(sed -n -e "/^${comment_re} -\{8,\} >8 -\{8,\}\$/q
    -+		   /^diff -/{p;q;}
    -+		   /^Index: /{p;q;}" "$1")"
    ++scissors_line="^${comment_re} -\{8,\} >8 -\{8,\}\$"
    ++comment_line="^${comment_re}.*"
    ++blank_line='^[ 	]*$'
    ++# Disallow lines starting with "diff -" or "Index: " in the body of the
    ++# message. Stop looking if we see a scissors line.
    ++line="$(sed -n -e "
    ++	# Skip comments and blank lines at the start of the file.
    ++	/${scissors_line}/q
    ++	/${comment_line}/d
    ++	/${blank_line}/d
    ++	# The first paragraph will become the subject header so
    ++	# does not need to be checked.
    ++	: subject
    ++	n
    ++	/${scissors_line}/q
    ++	/${blank_line}/!b subject
    ++	# Check the body of the message for problematic
    ++	# prefixes.
    ++	: body
    ++	n
    ++	/${scissors_line}/q
    ++	/${comment_line}/b body
    ++	/^diff -/{p;q;}
    ++	/^Index: /{p;q;}
    ++	b body
    ++	" "$1")"
     +if test -n "$line"
     +then
     +	echo >&2 "Message contains a diff that will confuse 'git am'."
3:  83c100a73ec < -:  ----------- templates: detect messages that contain a separator line
-- 
2.52.0.362.g884e03848a9

