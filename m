Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46721230270
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 04:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773462440; cv=none; b=Nqa3+JWd5PWOXZYgv96xGZnUS+ApoBt0XQWr+49WoMEUwDk2FWRhEWfDxiIRz63ev0kEyVgS/mx1wo5s0JN961PZdU5IMd4/nvLDvcECJtx9QQ4186jc7uJT/nRdoi3SkNcxKQVxmdeOIFf2d2Z9CybiosAwL3+POjGZ4VElID8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773462440; c=relaxed/simple;
	bh=Wv2TXhhjHrK++bkuNxpdOSJzPh0zqYWLWRxkXGz0bXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGSJO9XcDBqUPsXISE5M3VFD6KY8UIsoAtZ4sdZhv9FuSOGjjFdetfcIxCIuchfpr/B3ENDbcVHczmz3jg5zP/PtPzlSGGK0t8CTA5wIsqnsXhcHvsgUZYgKmNbCsj8PQYfCONCIErCYaoU/+17zcqJBfzJiXWPhMGeEeYQVY3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=US53NvtO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="US53NvtO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D9D1C116C6;
	Sat, 14 Mar 2026 04:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773462439;
	bh=Wv2TXhhjHrK++bkuNxpdOSJzPh0zqYWLWRxkXGz0bXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=US53NvtO4ONBn956cq00IqUxNJnj/Pc8gUueK4HPDeJe76ywmHEk52EAyRsD022S7
	 +H5y7PngXJ9L9bTC5wCy+5NQQsAoUUrVDhuFOzXESy8zcA7YRjESutDCnG9Gq7I+Ik
	 VaK+0AgZUGJ4drAvcRhOEKVtGHOfSfXjVMCutg6NyyJY6h002HM2hJy/g+Z4xTMBxz
	 VNdixZsJAM20ex/GYno44gW9i1ISOkVXaxxylHti7GWFVghNmeDX+n2fMC8BfmDsAu
	 GP6L0qDhw/3cysxO4fyQTlae0BZOKBClEzJTnTKFFAmWrnSk3rqZKJTakqyTXjzhCu
	 ZsvRiRYR4TI4A==
Date: Sat, 14 Mar 2026 00:27:18 -0400
From: Konstantin Ryabitsev <mricon@kernel.org>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, 
	Arsh Srivastava <arshsrivastava00@gmail.com>, Arsh Srivastava via GitGitGadget <gitgitgadget@gmail.com>, 
	git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2] advice: add stashBeforeCheckout advice for dirty
 branch switches
Message-ID: <20260314-towering-tourmaline-seahorse-caf5f7@lemur>
References: <pull.2233.git.git.1773132678.gitgitgadget@gmail.com>
 <pull.2233.v2.git.git.1773140364525.gitgitgadget@gmail.com>
 <CAOLa=ZRfaSR2CisUrW0gLf_45KQj1wQZ70F4PZ5XcwWZ--+HhQ@mail.gmail.com>
 <CAOAgETMmLKcz2CWqfKCJeoTCfACMXz7M0d2g_zO5M53tnGqQuA@mail.gmail.com>
 <xmqqeclrwrz4.fsf@gitster.g>
 <CAOLa=ZQu1hyiwMpBxJ=0PhNCf6LQqBt3F3=kycDv9cZST_JTNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQu1hyiwMpBxJ=0PhNCf6LQqBt3F3=kycDv9cZST_JTNw@mail.gmail.com>

On Tue, Mar 10, 2026 at 10:09:25AM -0700, Karthik Nayak wrote:
> >> I will rework the patch in that direction and send a v4.
> >>
> >> Signed-off-by: Arsh Srivastava <arshsrivastava00@gmail.com>
> >
> > Just a comment by a bystander, but it confuses me quite a lot to see
> > in-body "Subject:" and "Sign-off" in a message that is *not* a patch
> > at all.  What are you signing off with this signature?
> 
> Tangentially, I know that b4 adds a "Sign-off" to the cover message.

This is a feature, because some subsystems use the cover message as the source
for the merge commit, so the cover message *is* a commit despite not being a
patch. :)

Regards,
-- 
KR
