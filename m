From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 0/3] teaching log's --glob=<glob> and friends to git
 shortlog
Date: Thu, 21 Apr 2011 10:40:27 -0700
Message-ID: <7vtydry038.fsf@alter.siamese.dyndns.org>
References: <20110421102241.GA16185@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pierre Habouzit <madcoder@madism.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 19:40:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCxs1-0005Bm-Sk
	for gcvg-git-2@lo.gmane.org; Thu, 21 Apr 2011 19:40:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754467Ab1DURkp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2011 13:40:45 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64034 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754223Ab1DURko (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2011 13:40:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F0E974835;
	Thu, 21 Apr 2011 13:42:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tODTfH8xdUaiLcRJ1X6z088bcsE=; b=hWlxqM
	Bc4s8WQO3j2rAyjq8RUX/O1rF/sZ19RAaC4gDeD5ec/EWVUqqMYZ26P6VTVDGzHD
	84X5ZPhyDow6BD059DElPPNO+7mRI5XC8fZnmRzLQY9LCnqBjn83Ks7NBwqrvkFU
	77KwWqiRVJuuTouwia0Ha8z5WbeiBjmYJKVZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iKwHfKIiW4cNbPYt/Vy082IeSayprRjh
	W+Xe2GV3NqdoMgFvX5pDLQDgwB9wWH3HE6AYNtiDezz1ew8oA9bQ2d51LbzbzN5O
	/p/M8b8gG8j668brx4zLx51g/AYIKs76/A8vQtXlm7Icn2RbR2cgEw59YcGFbj6Q
	TZ5i2RVv/BU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9D37C4833;
	Thu, 21 Apr 2011 13:42:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 10FB34824; Thu, 21 Apr 2011
 13:42:29 -0400 (EDT)
In-Reply-To: <20110421102241.GA16185@elie> (Jonathan Nieder's message of
 "Thu, 21 Apr 2011 05:22:41 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BEC70F9C-6C3E-11E0-B868-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171910>

Jonathan Nieder <jrnieder@gmail.com> writes:

> 	git rev-list ^HEAD --no-walk commit1 commit2 ...

That should be "git rev-list --no-walk ^HEAD commit1 commit2 ..." from the
syntactical point of view to begin with, but more importantly, what does
it mean to ask excluding commits reachable from HEAD without walking?

As ^HEAD is inherently about walking the history to paint the part of DAG
that are not interesting because the nodes in there are reachable from
there, the request that command line tries to make does not make much
sense.

As I said in

 http://thread.gmane.org/gmane.comp.version-control.git/170457/focus=170629

the "--no-walk" hack happens to work by accident, and we would need to
rethink the way it operates and revamp it.
