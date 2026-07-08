Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA42337BE8A
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 13:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783517739; cv=none; b=IOPkHGQJK2EYlaGfRgVhY+leCbGuMLst3tbPfGQKfWXmoH2PWthaCz3cEM7hqw89yTtYwz6Qurv3ALiw8nXevHvsXA/EIchgm5fRtQbbJVx/1KjIx8pDcvnCr3j6pbrahBcM51qsy1HqTe7Lj52ex+n8nLiWxBfMNto9H8+F57w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783517739; c=relaxed/simple;
	bh=ePgmCHj36LjKU3HetsZblwRqbD+I5RkvOm34pR30uWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uu78VM0q0oUgG+E0f6U3sVREy9kt8qWyq/xPDNqy3tEXyunxbIkneAjrJu6Bui0x//aRFg0rFqV6ayQqr5+XuLHlgxO7w1Dkp2F9ElhIrDm0zTI7HCJey8FQ2yB3OF9GaYrvhc1Zqv3B7+B090WeX2zAgL27Ws1CB3Y0guN2J7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JdFhU9i6; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdFhU9i6"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-69531108f25so1208849a12.2
        for <git@vger.kernel.org>; Wed, 08 Jul 2026 06:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783517736; x=1784122536; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aIf4FBp+5geJaLjbj+x7g2+WmVe0KgTeIMCa34aXFVo=;
        b=JdFhU9i6weeilAiY9PrAviC1n9Pycg2/9vp1xoRAuvCBwujk33pKlb4BvciyAaNAkT
         hv5w0EwpGybpUw9hI0Zp8CNi84sHRKUcsex00lPsPzVzoxSEkYfq+l9l8PMQB28nnZud
         y26OUOXSclH1xi4dI5IkE2kVOTWtq+Qp0oS7BmMhkab0f+gswJqTSfgdYMJVOknNJ761
         Makkp0mQQc2jNQFBmhnx336FZJn7kVr0kgytifzt+3m/Kk277UbZXnrG9Eauogvg4zh9
         NjXuVV+GVJ7zA/hW9otIi5F+O7BsX39I+3gnxqNmDlEhfKXwepzzRWj/NOUt/epUHH+0
         aAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783517736; x=1784122536;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aIf4FBp+5geJaLjbj+x7g2+WmVe0KgTeIMCa34aXFVo=;
        b=GSkAgnP7kWv+RF5g+so1rQ/v1lh8D6wu4ekWX5XGKSqKH0+J//g2iM5JwSsQW00OES
         PvsBizgY1rKO9JE5AH2x+mCx+KXi7Tj5rSauBfXK4gpvxNJj1a2sKwnov50ATaG8XXKT
         vQM0y8OwfYSqQTTYmQPX7avz/oorstfPEp8yeNl42/wjzRm80sLQJh2/sL6OPJi+T2T4
         9fxpf1WuAtAEJSIHuIDYm7QN2vdWMV/+G8Xgi5wTb1MrEJJks3p+ok9mfkTsrfGzGZMq
         afqB6n0X3sCSyGz9k0TS7ZOe39oaJrDZjrxsj/HbJX/Zu8Jr9lmPZRcXwa747IpOM6sV
         Kypw==
X-Forwarded-Encrypted: i=1; AHgh+Rrx8fu0uqzP7+I2zub78qn54sCWr1+EmL4G4rjZwWJ7Nf0PVym6nfAAd27UEtfICHLP1Eg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd32TrN2Rb6X2ph1obMFXLwbCTBj1XiBo2giUqROS5+P1dghYj
	cF3D0Vut+yTTnjQFnGbNigVLOOjGXdHKN2p8QZHynQghuHCgwXwSyvsh3j+GRw==
X-Gm-Gg: AfdE7ckL/BPd/A45DnM+IQ69+q8stE6aJdt6h7MReYD3znorOqJlzWXWI4HbkrWvvNW
	URzJNRcpR75qHlGiq6srs7vAxyIquHqbpRP9dc4VLuaHYXg/YxZo3hnYWO5MBEl1dsSjxKj/Xpi
	2ypaaWxy9DgxGCS8KSBec3N04A8HqCbbliH4KwOjz17BKf7Jqv0Rj3oXLtlCXw5ns9zjoDLn0uk
	FItblRO8Age1hwqSdiI4gObTrHG5knUXFj1B89TW1ojPsfous2TPYE9e4h1NKVrY9rGZ3WucZT0
	rhXGeu4e7A6l35sJm9jQg9Z33aiuar/UlPLofg01IUnKrNXRbz3SkHvc2hr3cnJSn/DQh1Q9Kd9
	rlK0pvkjYBQtB8T+BRHXQbnzDN24UWyQBuYq9NV9kJSqBHS3e4KvdrlsO59bdEa01UtP8tUwRN8
	N/ZBbraNMcmQnrC4RvvfocOrDldhfMwxx4hh4wflAa+1I3KoYoghARW9J/FR1V+atkpCY=
X-Received: by 2002:a05:6402:51c6:b0:698:7661:fc39 with SMTP id 4fb4d7f45d1cf-69ab44b5564mr1046639a12.31.1783517735475;
        Wed, 08 Jul 2026 06:35:35 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69a19ce4a60sm7770605a12.8.2026.07.08.06.35.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 06:35:34 -0700 (PDT)
Message-ID: <0b7e6d74-0287-4be5-a19f-ed8c5fbc9217@gmail.com>
Date: Wed, 8 Jul 2026 14:35:32 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] merge --abort: don't delete autostash before reset
 succeeds
To: Kris Point <KrisPointCSGO@outlook.com>,
 "git@vger.kernel.org" <git@vger.kernel.org>
Cc: "gitster@pobox.com" <gitster@pobox.com>
References: <SI1PPF1BAF45F0FA46A6EED57B732BB04D7ABFF2@SI1PPF1BAF45F0F.apcprd02.prod.outlook.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <SI1PPF1BAF45F0FA46A6EED57B732BB04D7ABFF2@SI1PPF1BAF45F0F.apcprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Kris

On 08/07/2026 02:51, Kris Point wrote:
>  From bf4b12438a83d81f2c8df6e39f6114ddd5002430 Mon Sep 17 00:00:00 2001
> From: KrisPointCSGO <KrisPointCSGO@outlook.com>
> Date: Tue, 7 Jul 2026 20:10:00 +0800
> Subject: [PATCH] merge --abort: don't delete autostash before reset succeeds
> To: git@vger.kernel.org
> Cc: gitster@pobox.com
> 
> In cmd_merge()'s --abort path, MERGE_AUTOSTASH was deleted before
> cmd_reset() was called. If cmd_reset() failed (e.g. due to a locked
> index), the autostash was permanently lost.

That's bad
> Instead, read the MERGE_AUTOSTASH OID without deleting the ref, run
> cmd_reset() (which itself calls remove_branch_state() ->
> save_autostash_ref() to persist the stash), and only apply the
> autostash on success.

I'm afraid I don't think this is the right solution. We only want to 
save the stash if there are conflicts when we apply it - that is why 
MERGE_AUTOSTASH is deleted before we do the reset - we want to prevent 
remove_branch_state() from saving it. If the stash applies cleanly then 
we should not save it. If the reset fails then we should keep 
MERGE_AUTOSTASH along with the other merge state files rather than 
saving the stash (which is actually what happens after this patch 
because cmd_reset() dies before it calls remove_branch_state()).

I think the solution is probably to stop calling 
builtin/reset.c:cmd_reset() and instead extend 
reset.c:reset_working_tree()[1] to do a "merge" reset by adding a 
"RESET_WORKING_TREE_MERGE" flag (or possibly we want to remove 
RESET_WORKTING_TREE_HARD from the flags and add a reset_mode member). 
Then we can call

	struct reset_working_tree opts = {
		.flags = RESET_WORKING_TREE_MERGE;
	};
	if (reset_working_tree(the_repository, &opts))
		die(_("could not reset index and working tree")); 
apply_autostash_ref(...); /* apply the stash */ 
remove_branch_state(...); /* remove merge state */

So we only delete MERGE_AUTOSTASH after a successful reset and we only 
save the stash if it applies with conflicts. That's all a bit more 
involved than the patch here - please do give me a shout if you want 
some more information.

Thanks

Phillip

[1] Note that in the master branch this function is called reset_head(),
     you should base the fix on top of the "ps/history-drop" branch which
     is in "seen" (currently the tip is d11b348f784 (builtin/history:
     implement "drop" subcommand, 2026-07-01) but that might change when
     Junio rebuilds "seen".


> Reported-by: KrisPoint
> Signed-off-by: KrisPoint <KrisPointCSGO@outlook.com>
> ---
>   builtin/merge.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 5b46a596f0..5d9a242027 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -1427,15 +1427,14 @@ int cmd_merge(int argc,
>   		if (!file_exists(git_path_merge_head(the_repository)))
>   			die(_("There is no merge to abort (MERGE_HEAD missing)."));
>   
> -		if (!refs_read_ref(get_main_ref_store(the_repository), "MERGE_AUTOSTASH", &stash_oid))
> -			refs_delete_ref(get_main_ref_store(the_repository),
> -					"", "MERGE_AUTOSTASH", &stash_oid,
> -					REF_NO_DEREF);
> +		refs_read_ref(get_main_ref_store(the_repository), "MERGE_AUTOSTASH", &stash_oid);
>   
> -		/* Invoke 'git reset --merge' */
> +		/* Invoke 'git reset --merge' (which also cleans up merge state,
> +		 * including saving the autostash to the stash list).
> +		 */
>   		ret = cmd_reset(nargc, nargv, prefix, the_repository);
>   
> -		if (!is_null_oid(&stash_oid)) {
> +		if (!ret && !is_null_oid(&stash_oid)) {
>   			oid_to_hex_r(stash_oid_hex, &stash_oid);
>   			apply_autostash_oid(stash_oid_hex);
>   		}

