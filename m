From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 07/14] trailer: add interpret-trailers command
Date: Thu, 06 Feb 2014 16:10:06 -0800
Message-ID: <xmqqiosrwzoh.fsf@gitster.dls.corp.google.com>
References: <20140206194123.325.99451.chriscool@tuxfamily.org>
	<20140206202004.325.48784.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Feb 07 01:10:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBZ1e-0000fi-51
	for gcvg-git-2@plane.gmane.org; Fri, 07 Feb 2014 01:10:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893AbaBGAKX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Feb 2014 19:10:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51582 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750968AbaBGAKU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 19:10:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF6FA6A20B;
	Thu,  6 Feb 2014 19:10:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ynn8OwEILeTSv6nTfVE3KQiQrag=; b=CPpg1e
	fjidH/1cp2u2uF+qTDoOa+JkRXm9cuQ6riTAH1U02tgBcx3QB4EIgOHFx5gHTEV9
	MU3QR5RLm2dwVhXqVqJkH1pBQ2wVupt01U6POHP48zN3MFgiYBLPmUlygAxv53q2
	t1HTvM9zQs0xpam7bD4sohtqU5d12fFkwrao4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jtrGCLOQbPeTfrYy3Zel1sPQWFJvOSxv
	WPg+53khUn++d4OVFKtxPA3EMJFesg+danYqA/WqRbtSjcOwBgGlKpcKF5Nnlv8f
	Djurf3MAH43nlOktQfmDtcCdZYh2i2ZEUoAfjpKTvB0TUKljmHwuW+YQo8hlU41l
	v5U7B73Ctzk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7AB086A207;
	Thu,  6 Feb 2014 19:10:19 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0102F6A201;
	Thu,  6 Feb 2014 19:10:15 -0500 (EST)
In-Reply-To: <20140206202004.325.48784.chriscool@tuxfamily.org> (Christian
	Couder's message of "Thu, 06 Feb 2014 21:19:56 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 38B2B2C0-8F8C-11E3-8EE4-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241752>

Christian Couder <chriscool@tuxfamily.org> writes:

> diff --git a/git.c b/git.c
> index 3799514..1420b58 100644
> --- a/git.c
> +++ b/git.c
> @@ -383,6 +383,7 @@ static void handle_internal_command(int argc, const char **argv)
>  		{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY },
>  		{ "init", cmd_init_db },
>  		{ "init-db", cmd_init_db },
> +		{ "interpret-trailers", cmd_interpret_trailers, RUN_SETUP },
>  		{ "log", cmd_log, RUN_SETUP },
>  		{ "ls-files", cmd_ls_files, RUN_SETUP },
>  		{ "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },

Does this even need to have a git repository?  What is the RUN_SETUP
for?
