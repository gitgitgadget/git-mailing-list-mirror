Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F8342CB12
	for <git@vger.kernel.org>; Mon, 27 Jul 2026 17:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785171671; cv=none; b=pGtAftUAV1ZiK3haPmSHb8ygUYgWpDLvlO1zPxED3jLwkP9+9cP4k6kFCXOH/ICP0mNnchQXy91hCCeY5p7sPVcBpqO0fSR3B/xQX/SQq6By0xRY0qEuvgo0v7xYGK+FrIQVesGv2H1Vadh1XKlPlfdfyABSx7QuMnXiKB82yO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785171671; c=relaxed/simple;
	bh=HXqiR8A3XUO8WRCPCY5NzpOuvv8IpMp24nHdOIy7tjs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=StDqTWhz5SO0KsTw/K3AXzjj2t2hQrjG3w95dxIFVs23Br84VTowXxmxsd/8n7Iasdivkwc2RZom6b1RrQoxfeWVb1kV/QHIaIA95CVphL6N1q7fditH0kMrd2mDlyOvaNlot6yaEN4wVekoKIVwHkyz5VG+g0EQpdbCSeZKg2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FpkJ3pED; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W3Kixxv3; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FpkJ3pED";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W3Kixxv3"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id E6886EC0189;
	Mon, 27 Jul 2026 13:00:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 27 Jul 2026 13:00:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1785171659;
	 x=1785258059; bh=xsKy19jGzm9lXFLH/SI2N2xmEeFOUx1tQQ34bpQBlsY=; b=
	FpkJ3pED2/Pvl2YrY9uF5qnanr+iuQ17CIqXLZ4qgiIYG1h6lewHKLGgZpEFSfRM
	NaJ4hWF4PkfiXn0SOFc3/CgruzRd5fSjRnote71i9trsK4TKeutAS+kJCQWfcMH9
	9wPu0NmVEME6ISxuPk2ExvxA0gtmr+vfCVslQM5ktMR+ToeZv62FkPkshaZjSBoW
	MkfrcvFhibV2/LA30F/BW1fK4AT/38dGnHpkNKdgpldNz2GXiCDPc6YBbGy33iIx
	PZlc/iDNYyeMpG4gUIS/MKNKcJU0Tb05crKd3ax3UimWuNxEcpqdhXwjXGT2acWN
	jM9LGsrwRYBGew7SwRrsdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785171659; x=
	1785258059; bh=xsKy19jGzm9lXFLH/SI2N2xmEeFOUx1tQQ34bpQBlsY=; b=W
	3Kixxv3r+o62b9jY1N0pYak0QGK6Tja4oVnaQF/ChftDCTcPIpS1aHxStlBctQNm
	UpOZnX8WzxGcI4mdrm+7ZWJJ5C5fieHvc9vtITXqw3QaVBj7izWdzq+Oa1jUrev3
	1RGEZg2hcuV6n0dK4peUX7pzyA9LnFXyRgOt9VDs7Oh0e25TyhsRCA2Sb31lgOyJ
	WCQe0rIkkE8N3RaagzXAmmRWp6daIQMk77M8nEYjPOGxH64t/u/6Iti4/AS7Fiq6
	4QUoPiCZZdTBlrkzC+dwIv/u3MLeNqPbwe6JTx+QF+sQ7+3DD19XJhq1Hi4KASm4
	c5RVYy0vUHhjkvhOSIE1Q==
X-ME-Sender: <xms:y45navfoych0gchffKlyPL_Bx5w_1uWyBirSjP59VFTMMtow1JxZDA>
    <xme:y45nasPbKD6NtMV1qWAEmPUSc-52O2XZsJ3aOpGgG6xWGKRIM_jzAQK3B5oUgxTcA
    RTILevk6ZUHN-pxvfrbpFUCAjfteji5_R5Q9QoLckCJH039W6Md>
X-ME-Received: <xmr:y45natjRhEzIXHP2jSQoI9EmRyI4HF8bkTH1EzYgTltS5bdqUXsX2hKxknVNVO2yiQ-KBRvu5I2AnPJ51TdDjCUTw4-33uks2A>
X-ME-Proxy-Cause: dmFkZTGErET98E1oMpw2aM9FReZ8WMjU50e+kvcZKzs2uL5t880zsOqpZUiQZykD5C7gww
    A9X06SlGzjRvYNhyqRoejxXzGWNruKoneVY2Zy9k4ohxUjZ+6zq3xIEGWtaHf1Wk90TWtd
    uKfLO3AtD/QNi/jr+ThMb2zYDvO5xFiPTc1VYvc/VW77aJMZFU3YSNEYKFC4yXEmbhL07C
    lPsASYZaPbOrbPW5KZ6i6NG4LM4UYbS5H/eokDbWK7jKeLzEVykOiraQGERF4MEkZbbCZP
    3LYMgkKQpV6Q0zjeqQGiGuxlE2nRqCqPqXVC3eI1YEkQyFxqaenRBOGBkKHz00uAJm6LnR
    DgJZb+ghL4n+aN3y+93ePHUvAZ5vDe70fF0cJZehUw74ZLUYkJCcQc+ZmZWTJyLsxq92m+
    3fWDkIRFYfCcAI/LwSYSpCz5E0BWUk9fD9KziH6MqztHmHmC9iT7lh8dQmUxpmSahO3lc5
    aLXB7OemCiC3QEz/gULkVsneer5+vU+flFbHwozcRSmHVjde8U5hF9I2vP0murG5BiVhR4
    GdwNEiCo3Nw275OL+ZT6kKoo5JKz3dvU7O5iW/UMJFgWOWKcv5/YLn1+KlJTyu3YM5QMCY
    WOeuq7IpDaIxKU4vq1AlcboQpEYnQHmF8/+q4eXpPcV0hiciBfLnW3NQ2siQ
X-ME-Proxy: <xmx:y45nav12VYVOfe_AMDKC33-f94xzMdhmmWjYbb5j2th_S8_e9iS3rg>
    <xmx:y45nangtyFK5U15nAMrjd31D6IOBRQJzv4uirDrj7P-RlT9gUlCUMA>
    <xmx:y45navd5S2FHHmT3VcoApM03jfsNyruonC8uhIig1Ley6IKLjL9iuw>
    <xmx:y45naqnrVWabDArGNFclDzzRrHW64ujdp5J6em_vttjlLr6WR1sIeA>
    <xmx:y45nahivBv7AIAt0J7ngF_Jm0nIH6m5ShnGC9WbX67Y3tkBlW8DS_N4o>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jul 2026 13:00:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Emin_=C3=96zata_via_GitGitGadget?= <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Emin =?utf-8?Q?=C3=96zata?= <eminozata@proton.me>
Subject: Re: [PATCH v2] stash: add 'reword' subcommand
In-Reply-To: <pull.2180.v2.git.1785149687514.gitgitgadget@gmail.com> ("Emin
	=?utf-8?Q?=C3=96zata?= via GitGitGadget"'s message of "Mon, 27 Jul 2026
 10:54:46
	+0000")
References: <pull.2180.git.1784190706028.gitgitgadget@gmail.com>
	<pull.2180.v2.git.1785149687514.gitgitgadget@gmail.com>
Date: Mon, 27 Jul 2026 10:00:57 -0700
Message-ID: <xmqqbjbsmkom.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Emin Özata via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +	refs_for_each_reflog_ent_reverse(refs, ref_stash,
> +					 collect_reword_entries, &data);
> +	if (data.nr <= idx) {
> +		error(_("%s does not exist"), info->revision.buf);
> +		goto cleanup;
> +	}
> +
> +	if (!oideq(&info->w_commit, &data.entries[idx].new_oid)) {
> +		error(_("%s changed concurrently; try again"),
> +		      info->revision.buf);
> +		goto cleanup;
> +	}
> +
> +	for (i = 0; i <= idx; i++) {
> +		struct commit *stash = lookup_commit_reference(the_repository,
> +							       &data.entries[i].new_oid);
> +
> +		if (!stash || check_stash_topology(the_repository, stash)) {
> +			error(_("%s does not look like a stash commit"),
> +			      oid_to_hex(&data.entries[i].new_oid));
> +			goto cleanup;
> +		}
> +	}
> +
> +	if (refs_delete_reflog(refs, ref_stash)) {
> +		error(_("could not rewrite %s"), ref_stash);
> +		goto cleanup;
> +	}
> +
> +	transaction = ref_store_transaction_begin(refs, 0, &err);
> +	if (!transaction)
> +		goto restore;
> +
> +	for (i = data.nr; i-- > 0; ) {
> +		if (ref_transaction_update_reflog(transaction, ref_stash,
> +						  &data.entries[i].new_oid,
> +						  &data.entries[i].old_oid,
> +						  data.entries[i].committer,
> +						  i == idx ? reworded_msg :
> +							     data.entries[i].msg,
> +						  index++, &err))
> +			goto restore;
> +	}
> +
> +	if (ref_transaction_commit(transaction, &err))
> +		goto restore;

Is this a joke implementation, or is our reflog API so feature-poor
that it does not even allow replacing a single entry, leaving the
application to slurp everything, remove it, and recreate everything
from scratch with only a single entry modified in the middle?

What happens if your process gets killed after refs_delete_reflog()
returns but before finishing writing out what you collected?  The
copy you hoard in memory is the only copy, and we will lose the
data.

Use of a transaction here does not help us at all.  When we abort,
we end up losing the reflog we had on disk before starting that
transaction.

Am I reading the code incorrectly?  If I am not, I doubt that the
above implementation is acceptable.

I wonder if the reflog API needs to be extended before we can
implement this properly.  I imagine a set of functions like (there
may be others)

 * refs_reflog_replace(ref_stash, idx, &reflog_data);

   This would replace the reflog entry at idx with the data supplied,
   which would probably be a pointer to something like:

        struct reflog_data {
                const struct object_id *new_oid;
                const struct object_id *old_oid;
                const char *committer_info;
                const char *msg;
        } reflog_data;

   The files backend would implement this by doing something like
   the following sequence:

   - open a temporary file for writing, and the current reflog file
     for reading (with a lock);
   - copy the contents of the current reflog file to it, up to the
     specified index;
   - write out the single entry supplied in the reflog_data
     structure;
   - skip one entry in the current reflog file (which we are
     replacing);
   - copy the remainder of the current reflog file;
   - atomically replace the current reflog file with the temporary
     file.

   The implementation for reftable may be vastly different, but
   being a more database-oriented backend, it may be simpler to
   replace a single entry in it.  I dunno.

 * refs_reflog_edit_in_bulk(ref_stash, num_edit, reflog_edit[]);

   This would give us a bulk-edit interface, where reflog_edit would
   be an array of structures, perhaps like this:

        struct reflog_edit {
                int idx;
                enum {
                        DELETE_REFLOG_ENT,
                        REPLACE_REFLOG_ENT,
                        INSERT_REFLOG_ENT,
                } what;
                struct reflog_data data;
        } reflog_edit[];

   The '.what' member would instruct the function what to do at the
   specified '.idx' in the reflog, whether to delete the existing
   entry, replace it, or insert a new entry.  The '.data' member is
   used when replacing or inserting, but is ignored when deleting.

   You may require the caller to sort the elements in this array in
   increasing order of the '.idx' member if it makes the
   implementation easier.  Or the implementation can sort the array
   internally before starting to process the request.

will become the foundations of such a feature.
