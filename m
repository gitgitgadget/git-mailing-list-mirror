Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8249FEC4
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 01:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728352759; cv=none; b=FaX8F+6exd9ewy63/aZ8BJB8EOdfhl+zG1cxzr6VO41VTekb4BPvE15k5b3KvlhEA/I2htZk+jBEF3Bcrre1aYxNulRrW1pllLNrtU2ZQuDKlUKJQ9Gvur5sHJ02Mm+WslrRO37VCFL01//pnPWJLK/bkk4OH/O9Wsm1wGGvJq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728352759; c=relaxed/simple;
	bh=TQr3gXBz7t3pvLBUjehY67F5CpRoiCtubU/2IRzrKyA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KI7w4AgbWtftzFPB0tyysa9xWmFDVPhLKFNqsVwLTQ+m9K6FQ0y0JYCvFKtiSw3aeotkDlJGaF/8hw+dimpxWx+xOb8KnsPsH3fpXg2ZMac/V4/ANgKW8kqws+KB7xOiIDufrlyYAJZGVd12VDYgBn8yeWXiqNIBIfUfNNs/MjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mariadb.org; spf=pass smtp.mailfrom=mariadb.org; dkim=pass (2048-bit key) header.d=mariadb.org header.i=@mariadb.org header.b=pEY9+Snc; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mariadb.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mariadb.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mariadb.org header.i=@mariadb.org header.b="pEY9+Snc"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7db54269325so4158977a12.2
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 18:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mariadb.org; s=google; t=1728352756; x=1728957556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2tYs3cx1siGdqJqgvbiLY0+VoWf2/uY0LEewX5c9LgM=;
        b=pEY9+SncEgODwj+q+5zthLI0ei8NvJFHTzIuiUQB6gfH/HGtjoXpYA2H05n3JbmtfD
         xLa8IxD1fupTfc0+LdxQR1F5/FZlMGLEIr0cAGqc7/CZmMHCQGLQtjWbHISdzjcPuDUR
         G2xkm20/1Dv5k/4zoY+7g/oRGW2hxQ1FuE4QRkdIhdAcnXCHpDEWN8GOLAiRwqhtL8D7
         mniNgrXcj3NclDpT+N/oECJHecAR4hhLz5Eh9Rro5oDvZu1PujORu+trISBgAF4vsAyu
         /ji0RYTQGlI7ZvsljUwBvIinRqemHAxa0CP5SUmqCha/3PXmdcj3jvZsOPem53jMOd9N
         mKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728352756; x=1728957556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2tYs3cx1siGdqJqgvbiLY0+VoWf2/uY0LEewX5c9LgM=;
        b=ja8fDGZpf18IeEQDYeR7hxq8so/BhgjU/IsDRPEUvb9HhE6PwIa050apqzwXmZTA5K
         0wFP4Y6E42ZE56aufdVxtXftWLeJ5WXbPbfUo+TY9iQW5grHSKIEAxHt4+deqASmKJte
         OdlxmwVYESmy+UK3R4XgIFjc4d6w5b1VvlJlK+u6j9MJblUAiGdhGWq9W1ve+dzo0b9l
         PAkdK64mhnFskxGLDDwSGdHIoprRbfKJiu2AZnmVjVL/74GakdZUzISVgEWcl1eN6YWB
         LtHEYqCS62ojcB5yBudUkWnBMtta6Q8MOtWGpb4zWZATSWPim/smCqNCHOXPIzuNijxn
         AL6g==
X-Gm-Message-State: AOJu0YxMt1gG2rqOq+EzHur7JyvCtLb7kc/Jczf41TBcd/vaTkX/ZkqL
	lW+YpVkLbl9cyO2rrvFmT/PjaQH8EsZROmPresmMAaA524M07KCESRvgXC/x6kjUOeGnkhNuz3f
	4tbo=
X-Google-Smtp-Source: AGHT+IFTvZaPVFCnPjqYFqXRr9+DXhf6zhUTMHSp4lykrBpax3z3VMOVBIs7CGXomt0RuLyedcBsQA==
X-Received: by 2002:a05:6a20:6f91:b0:1d2:e889:1513 with SMTP id adf61e73a8af0-1d6dfa354e0mr21878997637.17.1728352756452;
        Mon, 07 Oct 2024 18:59:16 -0700 (PDT)
Received: from bark.fritz.box ([206.148.31.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d695cdsm5112789b3a.183.2024.10.07.18.59.15
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 18:59:16 -0700 (PDT)
From: Daniel Black <daniel@mariadb.org>
To: git@vger.kernel.org
Subject: 
Date: Tue,  8 Oct 2024 12:49:53 +1100
Message-ID: <20241008015835.41678-1-daniel@mariadb.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <xmqq7carzpzi.fsf@gitster.g>
References: <xmqq7carzpzi.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I have this so far, but I need a hand with the test case.

With a manual hack of the code:

--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2450,7 +2450,7 @@ static int run_update_procedure(const struct update_data *ud)
                 * Now we tried the usual fetch, but `oid` may
                 * not be reachable from any of the refs.
                 */
-               if (!is_tip_reachable(ud->sm_path, &ud->oid) &&
+               if (is_tip_reachable(ud->sm_path, &ud->oid) &&
                    fetch_in_submodule(ud->sm_path, ud->depth, ud->quiet, &ud->oid))
                        return die_message(_("Fetched in submodule path '%s', but it did not "
                                             "contain %s. Direct fetching of that commit failed."),

I'm able to using the GIT_TRACE= of git submodule update arrive at the
correct fetching from origin in the test case where before the code fix
it was fetching from remote o1.

trace: run_command: cd sub; unset GIT_PREFIX; GIT_DIR=.git git rev-list -n 1 27fe1b65df6f55a58636afcba364dfcb64916cd6 --not --all
trace: start_command: /home/dan/repos/git/git rev-list -n 1 27fe1b65df6f55a58636afcba364dfcb64916cd6 --not --all
trace: built-in: git rev-list -n 1 27fe1b65df6f55a58636afcba364dfcb64916cd6 --not --all
trace: run_command: cd sub; unset GIT_PREFIX; GIT_DIR=.git git rev-list -n 1 27fe1b65df6f55a58636afcba364dfcb64916cd6 --not --all
trace: start_command: /home/dan/repos/git/git rev-list -n 1 27fe1b65df6f55a58636afcba364dfcb64916cd6 --not --all
trace: built-in: git rev-list -n 1 27fe1b65df6f55a58636afcba364dfcb64916cd6 --not --all
trace: run_command: cd sub; unset GIT_PREFIX; GIT_DIR=.git git fetch origin 27fe1b65df6f55a58636afcba364dfcb64916cd6
trace: start_command: /home/dan/repos/git/git fetch origin 27fe1b65df6f55a58636afcba364dfcb64916cd6

As Sergei said in the original referenced message "a submodule where the commit cannot be fetched by simply
`git fetch` and needs a direct fetch".

So this is the test case that I'm having trouble generating.

