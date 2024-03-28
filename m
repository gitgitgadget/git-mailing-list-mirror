Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1911BC49
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 01:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711588233; cv=none; b=nZ9RSmpRYxGdTKqmYThgSo1UqFwBaMRn4Pwr7HyoKHbuT+CIZ/8gP+ET8aW5MPAALBTjoppnQpj1WbTC+0Ke1IP2Q0NGflcQU0iwlj5Sy/7ThMnpADO77yu5Irp8xj0lGYSFwRmsVz8p3CWzNvyuS4ikidePfDhi0leKShlDF/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711588233; c=relaxed/simple;
	bh=58ykHhqPSNCNLLo6ZucKhK+9LEHnkOyq2eEQi7LAQS4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Njmy000M98CrrsyDkrcdNMv9ttP0gEZe7W3GvWLeZJ7Pk4PBv3TAl4SfJzGZUKzFKsHSKlmb8sq/1ncIlsSdUkJ+vJ+Hmt5Z23rhrzv971/4BH2lv6TSvYwvYACOwZNqxP8EYbui11dvyAdnPYtBc7PGzm/ZDKw5+6pNNvmo6Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UI+hlb0O; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UI+hlb0O"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3416a975840so272701f8f.0
        for <git@vger.kernel.org>; Wed, 27 Mar 2024 18:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711588230; x=1712193030; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pmk3Ak7GpxHCpDQ2iSyJkQx3xK9qJvhtisvLsjjxPkU=;
        b=UI+hlb0OqufvKMbcyJyCr2yEmXbW3P8LiOIkY5mvEJAuPP6NjQ976IuBkS/q7Sp+vO
         6oHZXR6/wGDo6d6sWsXypAEkGLWaUI5E1kyYQuJCNcX9kxKaQ0u0evY7+/pYth81ZarE
         2I57c0bWRU9YmEu3Ns+NT13QWDvx5ecw+/PUN5/4JbTC7ZTb/YcUSj6g4DQ/pdkPnIxz
         1LOIz/dmhTz2hAQlVu3dOqxK3nHQZD11yoJYtrRVTpcx8PyxVt+6+MaTDDLKbGx28mNr
         TUiDh9p88ee0uo41AnoAP/EjLHWL4QnGSCobFMee8Jq6+jAQE1N2BOsS5/ntX1pPhLKY
         VkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711588230; x=1712193030;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pmk3Ak7GpxHCpDQ2iSyJkQx3xK9qJvhtisvLsjjxPkU=;
        b=ukOzovSgMjl+dDrNkABMSHJsr5e35FB2DKyNlsXCvw2UPtLjZd2CeKNgYKcO34Emnw
         bEPmFihGagyMXp0Vuj+drxGPIL//1pVYM2gwutsEoXYzhW9cIo7XYn65luyqfVE9794A
         IIWOu2pChtcRziRQDUmjrXSQtx1XAWV/c0C/JM1l9pFLMyCdXyv3YOAraA7dX9cGYJuu
         2lYnAjLHzI7AKOK7PrD3CUNRaft+cHRDA7DyDocUFv7VPL97KaRySo9LDugqT0kBdVAN
         rzneX3E0XdYjRRN8OJmNJMAgAdKwA9YCLvNhTLdO5Qlpr8sampaVRelLbatDFrttenmZ
         gl6Q==
X-Gm-Message-State: AOJu0YwCniiesH6ot8yGVjbrJQXEKNFJsDyNy9Hhb2zQVPJmumeH5r+8
	LERy3JN1QPhCK4vKMVO73aupN/3VeVre6/e/TO6m/Kv3g+1h7jWqDl2HGDN2
X-Google-Smtp-Source: AGHT+IEqzy464jVmr51nQeXMLRkFvNWKcpgcZtWKBsHuuOL5IpQuio5/AmC20SXpi1ThHycNruUvLQ==
X-Received: by 2002:adf:fd49:0:b0:341:de11:e71b with SMTP id h9-20020adffd49000000b00341de11e71bmr647039wrs.14.1711588230153;
        Wed, 27 Mar 2024 18:10:30 -0700 (PDT)
Received: from gmail.com (200.red-88-14-41.dynamicip.rima-tde.net. [88.14.41.200])
        by smtp.gmail.com with ESMTPSA id hg6-20020a05600c538600b004148ff6ef54sm542130wmb.29.2024.03.27.18.10.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 18:10:29 -0700 (PDT)
Message-ID: <60d978d0-f69a-4b65-b4ba-d30dac8f112a@gmail.com>
Date: Thu, 28 Mar 2024 02:10:28 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 0/2] improve interactive-patch
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <2c99dee8-fa6b-4f4f-93b4-3f7a8e0901f9@gmail.com>
 <6f2ed406-2152-476b-b463-3010afe7e11e@gmail.com>
Content-Language: en-US
In-Reply-To: <6f2ed406-2152-476b-b463-3010afe7e11e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Let's reduce the verbosity in the interactive-patch process, in order to
make it less confusing.

Rubén Justo (2):
  add-patch: introduce 'p' in interactive-patch
  add-patch: do not print hunks repeatedly

 Documentation/git-add.txt  |  1 +
 add-patch.c                | 19 +++++++++++++++----
 t/t3701-add-interactive.sh | 22 +++++++++++-----------
 3 files changed, 27 insertions(+), 15 deletions(-)

Range-diff against v2:
1:  bbb3bbea1b ! 1:  ca2777cb12 add-patch: introduce 'p' in interactive-patch
    @@ Documentation/git-add.txt: patch::
             K - leave this hunk undecided, see previous hunk
             s - split the current hunk into smaller hunks
             e - manually edit the current hunk
    -+       p - print again the current hunk
    ++       p - print the current hunk again
             ? - print help
      +
      After deciding the fate for all hunks, if there is any hunk
    @@ add-patch.c: N_("j - leave this hunk undecided, see next undecided hunk\n"
         "/ - search for a hunk matching the given regex\n"
         "s - split the current hunk into smaller hunks\n"
         "e - manually edit the current hunk\n"
    -+   "p - print again the current hunk\n"
    ++   "p - print the current hunk again\n"
         "? - print help\n");
      
      static int patch_update_file(struct add_p_state *s,
2:  4d5626e1c4 ! 2:  d7ad5e5424 add-patch: do not print hunks repeatedly
    @@ Commit message
         Signed-off-by: Rubén Justo <rjusto@gmail.com>
     
      ## add-patch.c ##
    -@@ add-patch.c: N_("j - leave this hunk undecided, see next undecided hunk\n"
    - static int patch_update_file(struct add_p_state *s,
    +@@ add-patch.c: static int patch_update_file(struct add_p_state *s,
      			     struct file_diff *file_diff)
      {
    --	size_t hunk_index = 0;
    -+	size_t hunk_index = 0, prev_hunk_index = -1;
    - 	ssize_t i, undecided_previous, undecided_next;
    + 	size_t hunk_index = 0;
    +-	ssize_t i, undecided_previous, undecided_next;
    ++	ssize_t i, undecided_previous, undecided_next, rendered_hunk_index = -1;
      	struct hunk *hunk;
      	char ch;
    + 	struct child_process cp = CHILD_PROCESS_INIT;
     @@ add-patch.c: static int patch_update_file(struct add_p_state *s,
      
      		strbuf_reset(&s->buf);
      		if (file_diff->hunk_nr) {
     -			render_hunk(s, hunk, 0, colored, &s->buf);
     -			fputs(s->buf.buf, stdout);
    -+			if (prev_hunk_index != hunk_index) {
    ++			if (rendered_hunk_index != hunk_index) {
     +				render_hunk(s, hunk, 0, colored, &s->buf);
     +				fputs(s->buf.buf, stdout);
    -+				strbuf_reset(&s->buf);
     +
    -+				prev_hunk_index = hunk_index;
    ++				rendered_hunk_index = hunk_index;
     +			}
      
    --			strbuf_reset(&s->buf);
    + 			strbuf_reset(&s->buf);
    ++
      			if (undecided_previous >= 0) {
      				permitted |= ALLOW_GOTO_PREVIOUS_UNDECIDED_HUNK;
      				strbuf_addstr(&s->buf, ",k");
    @@ add-patch.c: static int patch_update_file(struct add_p_state *s,
      				color_fprintf_ln(stdout, s->s.header_color,
      						 _("Split into %d hunks."),
      						 (int)splittable_into);
    -+				prev_hunk_index = -1;
    ++				rendered_hunk_index = -1;
     +			}
      		} else if (s->answer.buf[0] == 'e') {
      			if (!(permitted & ALLOW_EDIT))
    @@ add-patch.c: static int patch_update_file(struct add_p_state *s,
      			}
      		} else if (s->answer.buf[0] == 'p') {
     -			/* nothing special is needed */
    -+			prev_hunk_index = -1;
    ++			rendered_hunk_index = -1;
      		} else {
      			const char *p = _(help_patch_remainder), *eol = p;
      
-- 
2.44.0.370.gd7ad5e5424
