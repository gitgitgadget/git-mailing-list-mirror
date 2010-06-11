From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] ll-merge: Normalize files before merging
Date: Fri, 11 Jun 2010 12:44:55 -0700
Message-ID: <7vd3vxicaw.fsf@alter.siamese.dyndns.org>
References: <1276202894-11805-1-git-send-email-eyvind.bernhardsen@gmail.com>
 <4C11CE75.7080706@viscovery.net> <4C11E717.4070508@gmail.com>
 <4C11EB0D.20208@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jun 11 21:45:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONAAD-00034k-6B
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 21:45:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760507Ab0FKTpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jun 2010 15:45:07 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37644 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760490Ab0FKTpF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jun 2010 15:45:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CEB3FBB01D;
	Fri, 11 Jun 2010 15:45:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YaZDZs9PkR3e/bIlAEkB0+UevD0=; b=TDHjSV
	er1MfsGKE1oUBmZEovsDDhYOpJdA6WF1tF79eP8O2Uv7X4qogLsM9zrsKbMFkZr7
	L0UWnGnSPQsVZuo1U5RKvuJ3bK+6AFiI8UE/mJuE6888VPxK/+bbHJAwRFTWqoel
	sGDgwFcv6oCitMUij4FKCa/oR1o6j9f+roKtM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PKcxfjfTKrhQFvkzdF5nhppxnFiHuCeE
	/Q3bKZ2GuJ48dYdG5iSjmYJ4Hwkh+TcdvvMZZ0lFNYChAXEIntQz1jUIHLQm4Zcq
	KC/1T1aHbEUfiBMWCZpMxYAMhyFUC/6d99g5NBXohTAWoFy9Xdg+R8NQnUYsWghK
	++xl8J4aUVs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 98C65BB019;
	Fri, 11 Jun 2010 15:45:01 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B71F2BB014; Fri, 11 Jun
 2010 15:44:57 -0400 (EDT)
In-Reply-To: <4C11EB0D.20208@viscovery.net> (Johannes Sixt's message of
 "Fri\, 11 Jun 2010 09\:51\:41 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D30D2F94-7591-11DF-A278-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148967>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 6/11/2010 9:34, schrieb Eyvind Bernhardsen:
>> On 11. juni 2010 07:49, Johannes Sixt wrote:
>>> I think you are going overboard here. Normalization should only happen
>>> only for data that moves from the worktree to the database. But during a
>>> merge, at most one part can come from the worktree, methinks; you are
>>> normalizing all three of them, though.
>> 
>> Well, that's sort of the point.  All three are normalized to (hopefully)
>> minimize the differences between them, increasing the chance of a
>> successful merge.
>
> I know what your point is. It is still inappropriate to call
> normalize_file() on data that comes from the repository. It is not the
> task of a merge procedure to blindly normalize data.

It is not "blindly", but "running normalization one _extra time_, as the
repository data is supposed to be canonical already", which is utterly
wrong.
