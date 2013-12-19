From: Junio C Hamano <gitster@pobox.com>
Subject: Re: questions / suggestions about history simplification
Date: Thu, 19 Dec 2013 12:20:52 -0800
Message-ID: <xmqq38lofv8b.fsf@gitster.dls.corp.google.com>
References: <20131219183645.GD23496@pacific.linksys.moosehall>
	<20131219190333.GE23496@pacific.linksys.moosehall>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git mailing list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Thu Dec 19 21:21:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vtk5c-0006W5-KB
	for gcvg-git-2@plane.gmane.org; Thu, 19 Dec 2013 21:21:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755634Ab3LSUU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Dec 2013 15:20:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49541 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754704Ab3LSUU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Dec 2013 15:20:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 22A745B7D1;
	Thu, 19 Dec 2013 15:20:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l/ckTSEDEt1DVxTfjghDdYjWIk8=; b=YOUSXe
	/bJE4ZvN7I45Knhf9hmJ3kchGFZX3WgMHQD2sVfgLqVR6u6d8u8QfHM29pNggKbU
	+bYOjoWEkJj6M07pbJLbdAke+uROOloU8kPE4q/F+q0WCQ05mj8LtvdGGGSZbQhe
	agqWFuD5C9lo9iMvHAmuQOOOgo8A8EooNUtNE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GPnV5tUVfb49X5CGWtsFh/uNv4hEsc1Z
	spOHXt0kGm6NyprAhUCfG+xsJcPWgT8viH72wcTvuRhj+Uh0c+TJ8LGKIq2mqMyH
	BSY8DT9zsqo5GR3yvPN6HKkiSQGsuExc/m4pVIGwFG9nE6CP0yKa6Rj+83k8Ec6Z
	hqDSPfvCuP0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E46F5B7D0;
	Thu, 19 Dec 2013 15:20:55 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 47C585B7CF;
	Thu, 19 Dec 2013 15:20:54 -0500 (EST)
In-Reply-To: <20131219190333.GE23496@pacific.linksys.moosehall> (Adam Spiers's
	message of "Thu, 19 Dec 2013 19:03:33 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0FCE2A5A-68EB-11E3-A994-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239538>

Adam Spiers <git@adamspiers.org> writes:

> 2. What difference does --dense ever make?

It is set by default, and --sparse is its opposite option, i.e. it
turns revs->dense off.

When revs->dense is turned off, the usual treesame logic does not
kick in to rewrite parents in a single strand of pearls (i.e. a
stretch of history that solely consists of non-merge commits).
	
> 3. Why is --sparse so called, given that it increases rather than
>    decreases the number of commits shown?

The number of commits in the output will increase by including
commits that are irrelevant to explain the history of paths
specified by pathspec in revs->prune.  The information density
decreases as the result, and that is what "sparse" signifies.
