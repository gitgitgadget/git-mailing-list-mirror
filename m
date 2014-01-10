From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: Subject: Something like cat-file for the index?
Date: Fri, 10 Jan 2014 13:58:44 +0100
Message-ID: <871u0g2dtn.fsf@gmail.com>
References: <CABtFQN6n_FKTfGt1ubkL51t8n_iJ0vcYW4ZEYLOkAsFNCq0GQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: Enno Weichert <enno.weichert@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 10 13:58:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1bfU-00089Z-6P
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jan 2014 13:58:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751950AbaAJM63 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jan 2014 07:58:29 -0500
Received: from mail-ig0-f178.google.com ([209.85.213.178]:60377 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618AbaAJM61 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jan 2014 07:58:27 -0500
Received: by mail-ig0-f178.google.com with SMTP id ut6so10446590igb.5
        for <git@vger.kernel.org>; Fri, 10 Jan 2014 04:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:in-reply-to:references:user-agent:date:message-id
         :mime-version:content-type;
        bh=hMoRjJ/uRL5gepiX0hAxQD9RM4Lyzzngv0Mk1mtNxVE=;
        b=GGZj5zQcAqhWECKvsZcVKdwYnOfINgE9j/+CXVOa4yv4ZOu2Uwbgk8nRhBpn6p0y9z
         U0c5AN3LDouCUj7c+28vrnU7fGiM+Qs9yZoEM3eYheQJMBosQCJuSO+Dh3n8bE78xLA4
         UFjy7XNYRl4UQKD/gDup4soK0bTziKOB9zkHhkld7v0Dc3h4TQ/CQ2v0iGwihOWelPly
         yONcW+Lxgp0C+TD/7/slYlvGXQ3gPp3u/Ckj6y/HbIyozucGwMNxkDtVMbrkK9RN5QoQ
         zjrd/e+gVh4KrDG7QwY4n75au1Ri9fgrqEp0YyNF2ZVB3X3oH5NEodvAuLvqQMGPhm6h
         UJAw==
X-Received: by 10.50.176.201 with SMTP id ck9mr3106536igc.46.1389358707004;
        Fri, 10 Jan 2014 04:58:27 -0800 (PST)
Received: from localhost ([216.18.212.218])
        by mx.google.com with ESMTPSA id f5sm2471299igc.4.2014.01.10.04.58.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jan 2014 04:58:26 -0800 (PST)
In-Reply-To: <CABtFQN6n_FKTfGt1ubkL51t8n_iJ0vcYW4ZEYLOkAsFNCq0GQw@mail.gmail.com>
User-Agent: Notmuch/0.17~rc1+8~g4a09c1a (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240301>


Hi,

Enno Weichert <enno.weichert@gmail.com> writes:
> Hi,
>
> I'd like to have a more technical look into the index file and what/how it
> stores data; call it educational spelunking.
>
> I know the index-format.txt but I'd really like to save me the work to
> implement a pretty-printed output based on it.
> I know ls-files but that's obviously not the whole thing.
>
> So: is there something like cat-file, that basically gives me a readable
> version of the information (version number and all...) in the index already
> implemented or did nobody care until now?

You can use `git ls-files --debug` and `git ls-files --stage` to get all
the information about the files in the index.  The meaning of the flags
is the only thing that's not shown by the command, and I don't think
there is a tool yet to examine them.

The undocumented --resolve-undo flag to git ls-files shows you the
resolve undo data that is stored in the index.

If you build git yourself, the `test-dump-cache-tree` helper can be used
to show all information about the cache-tree that is stored in the
index.

The you can get the version of the index either by using
`test-index-version` when you build git yourself, or by using `file
.git/index`, which in addition will give you the number of entries that
are in the index.

--
Thomas
