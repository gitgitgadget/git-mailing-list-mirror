From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 07/23] git_remote_helpers: push all refs during a
 non-local export
Date: Sun, 17 Jul 2011 16:36:17 -0700
Message-ID: <7vzkkcxyxa.fsf@alter.siamese.dyndns.org>
References: <1310821424-4750-1-git-send-email-srabbelier@gmail.com>
 <1310821424-4750-8-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	"Dmitry Ivankov" <divanorama@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 18 01:36:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qiast-0004EW-8d
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 01:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756007Ab1GQXgV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jul 2011 19:36:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38311 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755943Ab1GQXgV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2011 19:36:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E4B15433E;
	Sun, 17 Jul 2011 19:36:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=Ueq90sh9ezPG18RFUSN7WND9FAk=; b=laesiVCq9Ufj2BBQqhSm
	qKEj5PgSzbTASQ2+B8XAjvfuMDH+4uq4WFSQw1xd2PM30tWjryWjAQs6oic2u8Eu
	Ply5v1t2rup/ZQ2jCgDetu2Ho8JMX4lzp77/DsfOqqcBF1tJ69qLrA+GBiodoF4B
	cYfXzdUxgUNuoy2p+eb5NcM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=XIwb0OS6m9SzEq3ajzFGrzvGEECCV7CQZ3LlCZHixz5r/O
	lLxP8ptG/Ckiq+RdvFspAZPWliWXhchrxquG9HXLfeq6d1TxVuIrFnVoSiUILddz
	60mcvDxy7s3jloyAPlk/6ZoRfUZCCFrEdc19nP6aWWxEcN1glFZHHowbDYNWg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DAC8E433D;
	Sun, 17 Jul 2011 19:36:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4C199433C; Sun, 17 Jul 2011
 19:36:19 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 927C0ACC-B0CD-11E0-9BFA-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177322>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> From: Jeff King <peff@peff.net>
>
> When a remote helper exports to a non-local git repo, the
> steps are roughly:
>
>   1. fast-export into a local staging area; the set of
>      interesting refs is defined by what is in the fast-export
>      stream
>
>   2. git push from the staging area to the non-local repo
>
> In the second step, we should explicitly push all refs, not
> just matching ones. This will let us push refs that do not
> yet exist in the remote repo.
>
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
> ---
>
>   Unchanged

There used to be "This does not deal with forced (not-fast-forward) pushes."
at the end of the message, no?
