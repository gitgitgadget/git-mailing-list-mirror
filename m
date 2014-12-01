From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] Add another option for receive.denyCurrentBranch
Date: Mon, 01 Dec 2014 15:49:38 -0800
Message-ID: <xmqqr3wjnd65.fsf@gitster.dls.corp.google.com>
References: <cover.1417033080.git.johannes.schindelin@gmx.de>
	<cover.1417041787.git.johannes.schindelin@gmx.de>
	<ff9c17b14b4418ae9743a094989d5478dab19701.1417041788.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 02 00:49:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xvaiv-0002CJ-OE
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 00:49:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754183AbaLAXtm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2014 18:49:42 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54198 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753284AbaLAXtl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2014 18:49:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 89F7522BF6;
	Mon,  1 Dec 2014 18:49:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vczzFZfewRua7dqf62pNsTHmuUk=; b=MXuZHI
	52kURft//yYyDnqHKi9ucFRyU3eydagXslTekQ2J3k8wCBNEV6yQqTY81buGQaZs
	XDMXm37dLWdPix+FyRI8HUklCRQnbroGLRT5jiR71ioHrr6DIuA54EW4OLN+P6Fd
	KfHb2SgELVcpsMzbbcdZnvsc/wfuqH5aPsCxg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LRsz/VuKZTF4NR8triHwICKD+0PvUXw+
	5+jwNUTbC5PTvsObpUJDquWq6lAh/bgbt8apJcNXWepvjPXtbkrjuIgQAYlk2p8d
	y+bryDCYQVTCyZkDnaOW5J1kuV0dEMVn4yMQ0riw4jpUy0wMw3v7YpLFCQAu/K3m
	9Iq3UiLUhds=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F92B22BF5;
	Mon,  1 Dec 2014 18:49:40 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0993022BF2;
	Mon,  1 Dec 2014 18:49:39 -0500 (EST)
In-Reply-To: <ff9c17b14b4418ae9743a094989d5478dab19701.1417041788.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Wed, 26 Nov 2014 23:44:16 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B7131F20-79B4-11E4-9B28-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260516>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> +static const char *update_worktree(unsigned char *sha1)
> +{
> +...
> +	const char *work_tree = git_work_tree_cfg ? git_work_tree_cfg : "..";

I overlooked this one, but is there a reason why this has to look at
an internal implementatino detail which is git_work_tree_cfg,
instead of asking get_git_work_tree()?

I am wondering if that reason is a valid rationale to fix whatever
makes get_git_work_tree() unsuitable for this purpose.

Cc'ing Duy who has been working on the part of the system to
determine and set-up work-tree and git-dir.
