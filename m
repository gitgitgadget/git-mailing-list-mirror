Received: from mta-sndfb-w03.biglobe.ne.jp (mta-sndfb-w03.biglobe.ne.jp [27.86.113.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EB61170F
	for <git@vger.kernel.org>; Thu, 23 May 2024 15:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=27.86.113.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716478856; cv=none; b=pcxAK9w01smTp5F5T5xCxzKgK0Rp0IMM+4tADPamSjFWh1aXAanM7Alw0NLnUMeFRmm5/fTPAWQ9stqnD4j0/+a99XYo9kzi31Qm7XSyaTKe5YNzGSTG6Xxshl9I4/W8nBMO0QsRqUOJBDbj3nTY8oW0mImDlsCDgjZv7qzxvlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716478856; c=relaxed/simple;
	bh=CYi8ckqDK+ubZWQSx7rMjLR4vJB90pJd1WYnr6Y0lck=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=iYMzx6N55/vvaXZiiqKH86dwiZFNwnOqaApqpHIGFVhe73WnHsjmioO8MjiDyTsBBr/p9jNrvZEgxiAlA9pgn78JBUDeATvqfF5/gMcIt/XVty9MiRWpqF2uI5HHMs3jgWThguhAf65rsqssw04hca4L+d4pe9F9HtJWXGWqfDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kba.biglobe.ne.jp; spf=pass smtp.mailfrom=kba.biglobe.ne.jp; dkim=pass (2048-bit key) header.d=kba.biglobe.ne.jp header.i=@kba.biglobe.ne.jp header.b=Pa4T8z9i; arc=none smtp.client-ip=27.86.113.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kba.biglobe.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kba.biglobe.ne.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kba.biglobe.ne.jp header.i=@kba.biglobe.ne.jp header.b="Pa4T8z9i"
Received: from mail.biglobe.ne.jp by mta-snd-w05.biglobe.ne.jp with ESMTP
          id <20240523153309057.RBRP.49464.mail.biglobe.ne.jp@biglobe.ne.jp>;
          Fri, 24 May 2024 00:33:09 +0900
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [PATCH v3 1/1] macOS: ls-files path fails if path of workdir is
 NFD
From: "Jun. T" <takimoto-j@kba.biglobe.ne.jp>
In-Reply-To: <xmqqa5ki95i1.fsf@gitster.g>
Date: Fri, 24 May 2024 00:33:08 +0900
Cc: =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
 git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <C5E35F2C-2423-4571-B737-411F4D4B13B5@kba.biglobe.ne.jp>
References: <20240430032717281.IXLP.121462.mail.biglobe.ne.jp@biglobe.ne.jp>
 <20240521141452.26210-1-tboegi@web.de> <xmqqttir9hr2.fsf@gitster.g>
 <20240521205749.GA8165@tb-raspi4> <xmqqa5ki95i1.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3696.120.41.1.4)
X-Biglobe-Sender: takimoto-j@kba.biglobe.ne.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kba.biglobe.ne.jp; s=default-1th84yt82rvi; t=1716478389;
 bh=SOR/FaO2Hrbx+9fuWXVkOokPzGD0HIACnnlUNqKVO3E=;
 h=Subject:From:In-Reply-To:Date:Cc:References:To;
 b=Pa4T8z9iIFGgZ1dbK1Z0XQmq/X4k8mTePc7AM21Ggs9V3CFQRklOquRohY5OJrpDUR79mgjh
 7CqwIDHz/pCf+EndLrzU5BUjH3rn27X9uqI0+18kE1lGEj+VChPK7PKBXcAs/6o0QoSqpAQ2vg
 MJNcOWBJEsi68wBlbYcMywgepujHPlim5SPwP4LrQYvnHGJ6IKrMHI+0Te9IPUinT1Mg9bGCeg
 ZK+dI937cc3HsHtl3yL8stSDA5u9/imn+2vJjazuT7NlFhPvvxvGfae1a6jWGIV9iifDkYy4jD
 yCfawFa3FzddpAze4FMMu2kQJRLGcwpMb+TyWvlGtbS8w7Xw==


Unfortunately v3 still doesn't work.
'git ls-files NFD' works but 'git ls-files NFC' does not.

I think it better to test both "ls-config NFD" and "ls-config NFC".

The reason of the failure seems to be the same as v2, but
I describe it here in more detail (or too detailed).

(one of?) The problem is the_repository->config->hash_initialized
is set to 1 before the_repository->commondir is set to ".git".
Due to this, .git/config is never read, and precomposed_unicode
is never set to 1 (remains -1).

run_builtin() {
    setup_git_directory() {
        strbuf_getcwd() {   # setup.c:1542
            precompose_{strbuf,string}_if_needed() {
                # precomposed_unicode is still -1
                git_congig_get_bool("core.precomposeunicode") {
                    git_config_check_init() {
                        repo_read_config() {
                            git_config_init() {
                                # !!!
                                the_repository->config->hash_initialized=1
                                # !!!
                            }
                            # does not read .git/config since
                            # the_repository->commondir is still NULL
                        }
                    }
                }
                returns without converting to NFC
            }
            returns cwd in NFD
        }

        setup_discovered_git_dir() {
            set_git_work_tree(".") {
                repo_set_worktree() {
                    # this function indirectly calls strbuf_getcwd()
                    # --> precompose_{strbuf,string}_if_needed() -->
                    # {git,repo}_config_get_bool("core.precomposeunicode"),
                    # but does not try to read .git/config since
                    # the_repository->config->hash_initialized
                    # is already set to 1 above. And it will not read
                    # .git/config even if hash_initialized is 0
                    # since the_repository->commondir is still NULL.

                    the_repository->worktree = NFD
                }
            }
        }

        setup_git_env() {
            repo_setup_gitdir() {
                repo_set_commondir() {
                    # finally commondir is set here
                    the_repository->commondir = ".git"
                }
            }
        }

    } // END setup_git_directory

    precompose_argv_prefix() {
        # since the_repository->config->hash_initialized is still 1
        # .git/config is not read and precomposed_unicode remains -1,
        # and argv (if in NFD) is not converted to NFC
    }

    cmd_ls_files() {
        parse_pathspec(.., argv /* may be in NFD, see above */) {
            init_path_spec_item() {
                prefix_path_gently() {
                    abspath_part_inside_repo() {
                        work_tree = precomose_string_if_needed(
                                        get_git_work_gree())
                            # get_git_work_tree() returns NFD, and
                            # precompose_string_if_needed() does not
                            # convert it to NFC since 
                            # the_repository->config->hash_initialized is 1
                        worktree = NFD

                        returns 0 for "ls-files NFD" since both argv
                        and work_tree are in NFD, but returns -1 for
                        "ls-files NFC" since argv is in NFC.
                    }
                    returns NULL for "ls-files NFC"
                }
                die() at pathspec.c:499 for "ls-files NFC"
            }
        }
    }
} END run_builtin

I don't know how to fix the problem, but I think it better to avoid
calling precompose_{strbuf,string}_if_needed() before commondir
is set to ".git" and .git/config is successfully read.

Or reset the_repository->config->hash_initialized at some point?


