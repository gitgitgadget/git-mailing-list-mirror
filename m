Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F9C175A9E
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 13:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773841335; cv=none; b=hUwWTARhjWaFt/33O8wKiPrFdizsaGkEMw98VGNoD6uFgJDutJ749wz2g9Rv1GW/48Wc2aaCbOWZeGkE2IuO4qykclNm8hiuhGIrXANfnJYU13CmxS1gks02e4Oh0hflmdx+oJfWnfQUQxjX1HGkfYILV2Qy3BKGO9GlQvFnJGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773841335; c=relaxed/simple;
	bh=hVeUT7zeYj+Xr6jLyO7XOzImBC57kZ6tPHXHqWAEBuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jmshwAuV7qYDg3VkzBWfgYwmd0uU5BF+IJ5UUXJFmSeZdV5775drhhh/yUAlbHLlYpZLw+56Lrx2SnLC7ZIVivNCrtA/0fhOJrUS0QYJcHvG1flWetByrrXEF+R4FR4n/4k6Xdb4sStu5Jztubc25RTj+o4HL6R3TEwcnzeJcf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pru3S+hj; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pru3S+hj"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ad9a9be502so41506105ad.0
        for <git@vger.kernel.org>; Wed, 18 Mar 2026 06:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773841333; x=1774446133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rX91RG42UEaoRNvT2Avaeige+ElANPhp7jKSDTh1Bh8=;
        b=Pru3S+hj2qB5FGDobGIpM2JAD5/AiQydNhSLe3383JOnOlaJIrabpYmmwgAmom2OqB
         hx9w9/zI7ggqSw63M7YuYZp5JfkkEIDKTO0UaW9GedQLU/N9IAU+byChwTOSZy71MT5G
         nOooP9ZK7Wmb6GmQIBN5snPw6fF0m9V/yzPBn/xdRcGv+sJsmAkA+uXkIBa/gIwGwMtQ
         NIQSgeuf6kufNA7FR+iproOKYB72WRH08tVQ7vvYC1OOJIfo+6xulVeI6PhcyUPZPQmF
         /bhogFdFs/plpAwitDMrr++7AbhBrY9Mwgz5t6CXH01LaTHmVmnmkE6ilrmTEQfPauXw
         JqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773841333; x=1774446133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rX91RG42UEaoRNvT2Avaeige+ElANPhp7jKSDTh1Bh8=;
        b=ELCi7qN2LfMRkvL+wJbbsTF3k0W3ST8q9tKsZH+JMR5HtS4MgE4qXR9L7SX3KBEbqQ
         iHxT3rPJnt4xwiBg5gbjlioP/pZ0MwdYiFNeJzzW2QgqJLk2WT2uXzF/OBL4ozTj0miZ
         moelJ13MKxKgXRttvSXorkOK89al+GR6PI1nIYRAotWXHEj6+VV3E9q+LV2Bg070+Nk1
         7dcyUK6zJ14zEHFDf+p1EM2KUuh9FwdKo1hDft8veOIfhLAyRX+eyGzuDmC6A6bDTooA
         FC3cPI5JD8y15E4B1ffIPbBmFeT9hT7tzSrZcJVELv3hjmdCbddRdRWqw5pV/n2/wwJD
         ZnjA==
X-Forwarded-Encrypted: i=1; AJvYcCXg41qynrbl6V4zTTOhR2bm57GjpenWclL2F7NCsAbsJhM/6QEOLwLl3tbbeMAPpV6yC24=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7SdCVDvgJHVAtQ9B9FgEXE8jWjxCgKEWbqdFehO6ekSFqGFt0
	cNSa2OAOd7grHR6ushx6Gjyaa4Db7r+muosRipAcFp3dEqrcG6hupl66
X-Gm-Gg: ATEYQzxcLIqzv9gYjyhmPUEdqMkKa/lhuPv0zxsazuFEcI3MuWQT5C6zHG+i9chKRgk
	nIMsFxxuJuoYi8d/DHfkwHktfROHgUbUBXp8aQrgngP6aDcgMHeQC0B6K7n+8X87MnpMf1VZqMC
	4EoCvxO8omQtBUuolod5lwS61r+ZJnQEtx6MHh2vVzai9L4Jg4Ml3OCPNytP+41lkpWd+B7Nc3Y
	LJ6zcCMV3OlelZUq9xhaBbOInIaU4Y+0wq+q1BdnOZtL3FvtKyLhwFhcwq+sItCu0Yo2fH+GUgD
	XUCsRz89ummDz2bAB8SEWkvDUZKpbC3Ak8EifCxBmYVtlapiDaQ2kFS/1J9TeXjUDmLaDwa5Pe6
	+1vYgSGMUnKuRoWhg2k1mahw4K0JoVmXlyQZWbBLW/YaDAbdyNhceri3l2mzNAzrOopXBkNccu3
	Gd0/Xsgr2aJeRzJ5gIQ1tOElFSz/AMI68De0dh3uqORWXj
X-Received: by 2002:a17:902:eccb:b0:2ae:6192:8d8b with SMTP id d9443c01a7336-2b06e3101e3mr36434465ad.4.1773841332754;
        Wed, 18 Mar 2026 06:42:12 -0700 (PDT)
Received: from Pushkar.xu.edu.in ([103.92.44.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e4316b5sm39784265ad.23.2026.03.18.06.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 06:42:12 -0700 (PDT)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: pushkarkumarsingh1970@gmail.com
Cc: ayu.chandekar@gmail.com,
	christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	lucasseikioshiro@gmail.com,
	peff@peff.net,
	siddharthasthana31@gmail.com
Subject: [GSoC][RFC v3] Proposal: Improve the new git repo command
Date: Wed, 18 Mar 2026 13:42:02 +0000
Message-ID: <20260318134202.23472-1-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.53.0.582.gca1db8a0f7
In-Reply-To: <20260316130431.1318-1-pushkarkumarsingh1970@gmail.com>
References: <20260316130431.1318-1-pushkarkumarsingh1970@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Everyone,=0D
This is the third version of my proposal for "Improve the new git repo comm=
and" in Google Summer of Code 2026, updated based on Karthik=E2=80=99s feed=
back.=0D
=0D
The Doc version:=0D
https://docs.google.com/document/d/1HM1HNQqUrGdqFdUppc02BTmPuwXC2ozCw9mLrba=
VUHc/edit?usp=3Dsharing=0D
=0D
I'd appreciate any feedback on this.=0D
=0D
Thanks,=0D
Pushkar=0D
---------8<----------8<----------8<----------8<----------8<----------8<----=
------8<----------8<=0D
=0D
GSoC 2026 @ Git | Pushkar Singh=0D
Improve the new git repo command=0D
---------------------------------------------------=0D
=0D
=0D
Personal Information:=0D
---------------------=0D
Name: Pushkar Singh=0D
E-mail: pushkarkumarsingh1970@gmail.com=0D
=0D
Education: XIM University, Bhubaneswar, Odisha, India=0D
Year: II/III=0D
Degree: Bachelors in Computer Science & Engineering=0D
=0D
Time-Zone: UTC + 5:30 (IST)=0D
=0D
Personal page: https://pushkarscripts.com/=0D
Blog: https://medium.com/@pushkarscripts/=0D
GitHub: https://github.com/pushkarscripts/=0D
=0D
=0D
Pre-GSOC:=0D
---------=0D
=0D
I began exploring Git=E2=80=99s codebase by studying its documentation, =0D
reviewing prior mailing list discussions, and building Git from =0D
source. =0D
I focused on understanding the test framework, patch submission =0D
workflow using git send-email, versioned patch iteration, and =0D
the review culture on the mailing list.=0D
=0D
After becoming familiar with the contribution process, I started =0D
submitting patches.=0D
=0D
=0D
Contributions to Git (Chronological Order):=0D
-------------------------------------------=0D
=0D
* [PATCH v4] t1300: use test helpers instead of test builtins=0D
    Status: Merged into master=0D
    Thread: https://lore.kernel.org/git/20260104194812.15134-1-pushkarkumar=
singh1970@gmail.com/t/#u=0D
This patch is my first contribution to fulfill microproject =0D
criteria. It replaces legacy test -f and test -h checks with =0D
test_path_is_file and test_path_is_symlink in the test suite.=0D
=0D
* [PATCH v2] t1410: use test helpers in reflog rewind test=0D
    Status: Merged into master=0D
    Thread: https://lore.kernel.org/git/20260111191525.17087-1-pushkarkumar=
singh1970@gmail.com/t/#u=0D
Replaced raw file existence checks in the reflog rewind test =0D
with test_path_is_file and test_path_is_missing. The subject =0D
and commit message were refined in v2 following review feedback.=0D
=0D
* [PATCH] Documentation/config: fix replacement for --get-urlmatch=0D
    Status: Merged into master=0D
    Thread: https://lore.kernel.org/git/20260115110832.15315-1-pushkarkumar=
singh1970@gmail.com/T/#u=0D
    Related Bug Report: https://lore.kernel.org/git/CAGJzqs=3D0Zr2iqsTUZdjd=
wpbtaS7kuBOf=3DE_XT=3DvbdfyNTKkjNQ@mail.gmail.com/t/#u=0D
Corrected documentation that incorrectly suggested combining =0D
--url with --all for --get-urlmatch. Verified the behavior =0D
against the implementation and updated the documentation =0D
accordingly.=0D
=0D
* [PATCH v3] path: refactor normalize_path_copy_len for clarity=0D
    Status: Merged into master=0D
    Thread: https://lore.kernel.org/git/20260221110511.1592-2-pushkarkumars=
ingh1970@gmail.com/t/#u=0D
Proposed a refactor of normalize_path_copy_len to improve =0D
clarity while preserving existing control flow. The discussion=0D
focused on maintaining readability and minimizing structural =0D
changes.=0D
=0D
* [PATCH v4] subtree: validate --prefix against commit in split=0D
    Status: Merged into master=0D
    Thread: https://lore.kernel.org/git/20260203164815.68258-2-pushkarkumar=
singh1970@gmail.com/T/#u=0D
    Related Bug Report: https://lore.kernel.org/git/CAFePT4xDGegpEFuFemCXsH=
890E2WXnG3JzUZeiLi9KW8D8beOg@mail.gmail.com/T/#u=0D
Updated git subtree split to validate --prefix against the =0D
specified commit rather than the working tree. The change =0D
addresses a mailing list report where --prefix was incorrectly =0D
validated against the current working directory instead of the =0D
given revision. Added regression tests and revised the patch =0D
across four versions following review and CI feedback before =0D
integration into next.=0D
=0D
* [RFC] git repo info: expose repository paths=0D
    Status: WIP, Under discussion=0D
    Thread: https://lore.kernel.org/git/20260218183511.17195-1-pushkarkumar=
singh1970@gmail.com/t/#mdd8548b634142f4916e2911f7025e736a4789a07=0D
Proposed extending git repo info to expose additional repository=0D
path-related values currently accessible via git rev-parse.=0D
Initiated design discussion regarding path handling and output=0D
format, incorporating feedback during iteration.=0D
=0D
Additional Participation:=0D
=0D
In addition to submitting patches, I have:=0D
*  Reviewed patches from other contributors=0D
    (1) https://lore.kernel.org/git/CALE2CrTzYbMam_fi5HszSUFVZADE1haLtpBqhU=
md1ki9biM2hA@mail.gmail.com/T/#u=0D
    (2) https://lore.kernel.org/git/20260202134657.15320-1-pushkarkumarsing=
h1970@gmail.com/T/#u=0D
    (3) https://lore.kernel.org/git/CALE2CrQFZngj6_NDuf0S=3D_-nDrrf6b6r=3DC=
9jMyEVjwMqvh6J2w@mail.gmail.com/=0D
    (4) https://lore.kernel.org/git/CALE2CrTuZkFm1R3Bb6gFmrN1trr88vdO_7Aw6y=
cBYvFpWMEEtA@mail.gmail.com/T/#u=0D
    (5) https://lore.kernel.org/git/CALE2CrSu-JW___Lav0SnLPfwxB8QCRYMKQgsfb=
XCHrAQSEyDoA@mail.gmail.com/T/#u=0D
    (6) https://lore.kernel.org/git/CALE2CrQTvHeu21yLXtRg=3DA6ak9AB_vvwPirQ=
NFDjZ2AmhoTzTQ@mail.gmail.com/T/#u=0D
    (7) https://lore.kernel.org/git/CALE2CrR_Xrei32pc_gJ16mArZPjZ-+bNWWFnsJ=
3i+OGqbxwPcg@mail.gmail.com/T/#u=0D
*  Assisted in resolving a git rebase issue on the mailing list=0D
    (1) https://lore.kernel.org/git/CALE2CrQ415Ewm_F-DLZu=3DJY2BTWofmGgorEO=
a0D=3DUSr5d510SQ@mail.gmail.com/T/#madfc34c4334a7d62baa18b18e3c8fa83600f845=
5=0D
*  Studied the original discussions on git repo=0D
    (1) https://public-inbox.org/git/20250610152117.14826-1-lucasseikioshir=
o@gmail.com/t/#u=0D
    (2) https://lore.kernel.org/git/20251207190532.67107-1-lucasseikioshiro=
@gmail.com/T/#u=0D
    (3) https://lore.kernel.org/git/20260218211845.96009-1-lucasseikioshiro=
@gmail.com/T/#u=0D
    (4) https://lore.kernel.org/git/20260203221758.1164434-1-jltobler@gmail=
.com/T/#u=0D
*  Examined the implementation in builtin/repo.c=0D
=0D
=0D
The Plan=0D
--------=0D
=0D
I will be iterating on this project in blocks and with the=0D
review-driven approach. By introducing every changes in small,=0D
logically isolated patches, I'll ensure clarity, ease-of-review,=0D
and architectural stability.=0D
=0D
First I want to cover foundational repository path keys,=0D
because they create instant structural value and more closely fit=0D
with existing functionalities of rev-parse.=0D
=0D
For every key proposed or enhancement made, I will:=0D
=0D
  - Ensure behavior matches helpers currently used in git rev-parse, =0D
    such as repo_get_work_tree(), repo_get_common_dir(),=0D
    repo_get_git_dir(), and related helpers such as repo_git_path*(), =0D
    along with print_path() for formatting behavior.=0D
  - Currently, git rev-parse outputs paths based on options like=0D
    --path-format and also varies depending on the specific command=0D
    (e.g., --git-dir, --show-toplevel). This can lead to slightly=0D
    different behaviors across commands. The expected behavior for=0D
    git repo info is still under discussion (e.g., whether paths=0D
    should always be absolute, or configurable).=0D
    During the bonding period, I plan to:=0D
      - Review existing discussions on path formatting=0D
      - Align on a consistent default behavior=0D
      - Ensure compatibility with existing expectations from rev-parse =0D
  - Category-based queries represent a broader design decision affecting =0D
    the overall interface of git repo info, not just path-related fields. =
=0D
    I will evaluate their impact and ensure they integrate cleanly with =0D
    existing key-based querying before proposing an implementation.=0D
  - Add one key (or one closely tied family of keys) per patch.=0D
  - The current test coverage in t1900-repo-info.sh focuses on:=0D
      - Basic key-value retrieval=0D
      - Output formats (lines, nul)=0D
      - Error handling for invalid keys, formats, and flag combinations.=0D
      - Repository configurations such as bare repositories, shallow =0D
        clones, object format, and reference format.=0D
    However, it does not yet cover:=0D
      - Path-related keys (e.g., path.git-dir, path.toplevel)=0D
      - More complex repository setups such as linked worktrees and submodu=
les=0D
      - Edge cases involving relative vs absolute path behavior=0D
    I plan to extend the test suite to include these scenarios, ensuring =0D
    consistent behavior across different repository layouts while =0D
    preserving existing invariants.=0D
  - Update documentation accordingly.=0D
=0D
I will avoid large changes and focus on small, reviewable patches,=0D
instead of rapidly expanding features.=0D
=0D
=0D
Path Key Expansion=0D
------------------=0D
=0D
I will incrementally expose selected repository path values=0D
currently accessible via:=0D
=0D
  - git rev-parse=0D
  - git rev-parse --git-path=0D
=0D
My initial focus will be on foundational keys such as:=0D
=0D
  path.git-dir=0D
  path.common-dir=0D
  path.toplevel=0D
  path.superproject-working-tree=0D
=0D
Subsequent patches may introduce additional --git-path=0D
equivalents such as:=0D
=0D
  path.index-file=0D
  path.objects-dir=0D
  path.config-file=0D
=0D
Each key will be evaluated individually to ensure clarity,=0D
necessity, and consistent semantics.=0D
=0D
=0D
repo structure Enhancements=0D
---------------------------=0D
=0D
If maintainers deem it appropriate maybe I will tackle some =0D
carefully scoped improvements to git repo structure.=0D
=0D
Potential areas include:=0D
  - Distribution-oriented metrics, only if aligned with the=0D
    tool=E2=80=99s long-term direction.=0D
  - Low-friction structural metrics (e.g., path depth),=0D
    as long as they do not add excessive traversal cost.=0D
=0D
Any such enhancement will be introduced in small,=0D
standalone patches, taking performance, maintainability, =0D
and output stability into account. =0D
=0D
If scope or review timelines demand, I can push this work to =0D
later stages of GSoC or continue it after GSoC.=0D
=0D
=0D
Architectural Considerations=0D
----------------------------=0D
=0D
Where appropriate, I will:=0D
=0D
  - Prefer explicit repository context over global state.=0D
  - Avoid duplicating logic already implemented in rev-parse. =0D
    Where possible, I'll reuse existing helper functions rather =0D
    than reimplementing path resolution logic.=0D
  - Ensure that newly added fields do not change existing output =0D
    behavior (ordering, formats, or flag behavior), and remain =0D
    consistent with Git=E2=80=99s scripting-friendly output.=0D
=0D
Structural refactoring will only be undertaken when directly=0D
relevant to git repo and supported through review discussion.=0D
=0D
=0D
Timeline=0D
--------=0D
=0D
Keeping Git's iterative and review-driven workflow in mind, I've =0D
designed the timeline to focus on core enhancements in order to =0D
ensure that I can produce meaningful deliverables even if review =0D
cycles extend.=0D
=0D
=0D
Pre-Coding Preparation (Before Official Start)=0D
=0D
- Continue participating in git repo discussions.=0D
- Improve and restrict scope of path key expansion.=0D
- Confirm semantics for absolute vs relative path handling.=0D
- Define patch ordering to keep the submissions small=0D
  and logically independent.=0D
=0D
=0D
Community Bonding Period (May)=0D
=0D
Primary objective: finalize scope and ordering.=0D
=0D
- Confirm priority list of path keys.=0D
- Align on output stability expectations.=0D
- Evaluate category-based queries as a broader interface design =0D
  decision affecting all keys, and determine whether they should =0D
  be introduced in this cycle or deferred.=0D
- Identify specific areas in builtin/repo.c where new fields =0D
  can be integrated cleanly, reusing existing helpers and =0D
  maintaining consistency with the current key-to-field dispatch =0D
  structure.=0D
=0D
I will get to implementation once the semantics feel reasonably=0D
aligned through mailing list discussion.=0D
=0D
=0D
Phase 1 (Weeks 1=E2=80=934): Foundational Path Keys=0D
=0D
Objective: establish core path parity in git repo info=0D
with essential rev-parse values.=0D
=0D
* Weeks 1=E2=80=932:=0D
  - Submit path.git-dir=0D
  - Submit path.common-dir=0D
=0D
  I'll present these foundational keys early on to keep =0D
  semantics consistent, and stabilize output expectations.=0D
=0D
* Week 3:=0D
  - Submit path.toplevel=0D
  - Submit path.superproject-working-tree=0D
=0D
  These will provide working-tree inspection coverage and=0D
  support submodule-aware contexts.=0D
=0D
* Week 4:=0D
  - Submit selected stable --git-path equivalents=0D
    (e.g., path.index-file, path.objects-dir),=0D
    introduced incrementally, one per patch.=0D
=0D
I'll submit each key independently. When semantics are =0D
already aligned, I'll send consecutive patches while=0D
older ones will remain pending, which allows a significant =0D
overlap between submission and iteration.=0D
=0D
Midpoint Goal:=0D
 Deliver foundational path keys that are either merged or=0D
 in next, with consensus on semantics.=0D
=0D
=0D
Phase 2 (Weeks 5=E2=80=938): Additional Path Keys & Refinement=0D
=0D
- Finish the remaining agreed --git-path parity keys.=0D
- Address changes from review cycles of Phase 1.=0D
- Stabilize behaviour across edge-case environments.=0D
=0D
This phase purposely leaves time for review-guided=0D
iteration without expanding scope.=0D
=0D
=0D
Phase 3 (Weeks 9=E2=80=9310): Optional Enhancements=0D
=0D
Only if Phase 1 and 2 stabilize earlier than expected,=0D
I'll begin:=0D
- Introducing the grouped category queries(e.g., info paths),=0D
  subject to prior agreement.=0D
- Carefully extending repo structure with one metric =0D
  at a time.=0D
=0D
I=E2=80=99m not going to attempt any bulk metric expansion here.=0D
=0D
=0D
Final Weeks (Weeks 11=E2=80=9312): Consolidation=0D
=0D
Over the last weeks of this program, I will:=0D
- Address remaining review feedback.=0D
- Adjust patches if requested or rework them.=0D
- Finalize documentation.=0D
- Ensure CI stability and cross-platform behavior.=0D
=0D
During this time no new features will be introduced.=0D
=0D
=0D
Prioritization Under Constraints=0D
--------------------------------=0D
=0D
Considering Git=E2=80=99s iterative review process, I have structured the=0D
project so that foundational improvements are delivered first.=0D
=0D
If review cycles extend longer than anticipated, my priority will be:=0D
=0D
1. Core path parity (path.git-dir, path.common-dir,=0D
   path.toplevel, path.superproject-working-tree)=0D
2. Additional agreed --git-path equivalents=0D
3. Category-based queries=0D
4. repo structure metric extensions=0D
=0D
This ordering ensures that the most architecturally meaningful=0D
enhancements are completed even if optional improvements=0D
must be deferred.=0D
=0D
=0D
Post-GSoC Continuation=0D
----------------------=0D
=0D
My involvement in Git is not limited to the GSoC period.=0D
=0D
After the coding phase, I intend to:=0D
- Continue refining git repo through incremental improvements.=0D
- Address follow-up review feedback or deferred enhancements.=0D
- Participate in reviewing related patches where appropriate.=0D
- Contribute to ongoing efforts around repository introspection=0D
  and gradual libification.=0D
=0D
Over time, I hope to contribute not only through patches,=0D
but also by helping new contributors navigate the mailing=0D
list workflow and patch iteration process.=0D
=0D
If given the opportunity in the future, I would be glad to=0D
support mentoring efforts and help the community grow further.=0D
=0D
=0D
Availability=0D
------------=0D
=0D
My end-semester examinations conclude on March 28.=0D
Following this, I will not have academic obligations=0D
during the GSoC coding period.=0D
=0D
The project is expected to fall within the 175=E2=80=93350 hour=0D
range. I am prepared to commit at the higher end of this=0D
range.=0D
=0D
During the official coding phase (approximately 12 weeks),=0D
I will be available for 30=E2=80=9335 hours per week. This allows=0D
for approximately 360=E2=80=93420 hours of focused development time,=0D
comfortably covering the expected project scope.=0D
=0D
I will also remain active on the mailing list during the=0D
community bonding period and will use that time to refine=0D
design decisions and prepare patch sequencing.=0D
=0D
I do not anticipate any internships, travel, or major=0D
commitments that would interfere with this schedule.=0D
=0D
=0D
Blogging:=0D
---------=0D
=0D
For the past one year I have been writing technical articles =0D
on Medium, mostly related to Git workflows, developer tooling, =0D
and lessons from working with real codebases.=0D
=0D
I will be sharing weekly updates for the GSoC period to document =0D
progress and the discussions on these mailing lists for =0D
transparency, and more importantly, to help future contributors.=0D
=0D
Medium: https://medium.com/@pushkarscripts=0D
=0D
=0D
Risk Assessment and Mitigation=0D
------------------------------=0D
=0D
1. Review Cycle Duration=0D
=0D
Considering Git=E2=80=99s iterative mailing list workflow, existing =0D
patches might go through several updates before being =0D
accepted.=0D
=0D
Mitigation:=0D
  The project is structured so that foundational path=0D
  keys are delivered first. Independent patches allow=0D
  parallel review and refinement.=0D
=0D
2. Scope Creep=0D
=0D
Expanding both path keys and structure metrics=0D
may introduce unintended scope growth.=0D
=0D
Mitigation:=0D
  Optional enhancements (categories and additional=0D
  metrics) are explicitly deferred until foundational=0D
  work stabilizes.=0D
=0D
3. Semantic Ambiguity=0D
=0D
Path-related behavior (absolute vs relative,=0D
worktree interactions, submodules) may require=0D
careful alignment.=0D
=0D
Mitigation:=0D
  Semantics will be clarified during the bonding=0D
  period and validated against existing helpers=0D
  before implementation.=0D
=0D
---=0D
=0D
Thank you for your time and consideration. I look forward=0D
to contributing further to the project and continuing to=0D
learn through the review process.=0D
=0D
Regards, =0D
Pushkar Singh=0D
=0D
---------8<----------8<----------8<----------8<----------8<----------8<----=
------8<----------8<=0D
=0D
Changes in v3:=0D
- Clarified which existing helpers will be reused for path handling=0D
- Expanded discussion on path semantics (absolute vs relative)=0D
- Added details on current test coverage and planned improvements=0D
- Clarified expectations around output behavior=0D
- Reworked category-based queries as a broader design decision=0D
- Improved clarity in architectural sections=20=
