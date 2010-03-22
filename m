From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GSoC draft proposal: Line-level history browser
Date: Mon, 22 Mar 2010 00:41:20 -0700
Message-ID: <7v7hp4n6qn.fsf@alter.siamese.dyndns.org>
References: <41f08ee11003200218u59c45b6dl82a8eb56cc289256@mail.gmail.com>
 <81b0412b1003201335g7b37c51mfa3e2280210ebb7e@mail.gmail.com>
 <4BA544FC.7050007@gmail.com>
 <41f08ee11003202316w2fddc5f4jebda47f325451577@mail.gmail.com>
 <4BA61CF9.7040104@gmail.com>
 <41f08ee11003212048q1950eb3s95f1caf7ba640874@mail.gmail.com>
 <7vfx3tvv9y.fsf@alter.siamese.dyndns.org>
 <41f08ee11003212134s586aa71cs23255d02f38d53d1@mail.gmail.com>
 <7vhbo8syyf.fsf@alter.siamese.dyndns.org>
 <41f08ee11003220031p6fda651eycff2641df10864da@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitzilla@gmail.com, Alex Riesen <raa.lkml@gmail.com>,
	git@vger.kernel.org
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 22 08:41:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtcGa-0001ag-G9
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 08:41:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753534Ab0CVHlf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 03:41:35 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47632 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417Ab0CVHlf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 03:41:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9783FA4130;
	Mon, 22 Mar 2010 03:41:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TS7Ug7XGqKa3ax20H82Xg+pALmI=; b=IPWmDS
	4HdC05/3F4QsJm7B/310pH4KJOfCkluFUG6Rhb/H1FsipPojT7u/zGtsDXRAuBPp
	b2pRdeqzmL4Lh+9YFYynkrR2Aa8cqaO+fIvSkjI7RqR3ZU6AvPPWRcnNUscqQ+71
	Je8OQc9cZkT0slY3NcObE3zXPZTiocnA4HjS0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Rx44jeZTHJmB0xaXvVljM8Uh+qKcupzH
	dqhrCuHs3MKTVzra3datbaPHiu/tP0VrQvjJoZKoWCPqop8FU1P13PUhEpf7CKhM
	s8Tcb+lyErBY1CaBjecqDsAXub2LcuJ3orzcIFDaGsR6XTTgP4yM3JV7ZprzfGFN
	Vt+8B5A91LQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3EFA4A412F;
	Mon, 22 Mar 2010 03:41:27 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 72EE7A412D; Mon, 22 Mar
 2010 03:41:22 -0400 (EDT)
In-Reply-To: <41f08ee11003220031p6fda651eycff2641df10864da@mail.gmail.com>
 (Bo Yang's message of "Mon\, 22 Mar 2010 15\:31\:27 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 529C9CA0-3586-11DF-9D59-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142906>

Bo Yang <struggleyb.nku@gmail.com> writes:

>> When you want to know where the first few lines of Makefile
>> came from, and if blame says the first line came from 2731d048, that
>> really means that between the revision you started digging from and the
>> found revision, there is no commit that touched that particular line, but
>> equally importantly, that before that found revision, there wasn't a
>> corresponding line in that file---blame stopped exactly because there is
>> nobody before that found revision that the line can be blamed on.
> ...
> Yes, this is not satisfying. But as I understand, the line level
> history browser will do more than just this. It will not stop on 'step
> 4', it can follow the change history recursively and deeply, to find
> more.

I am actually questioning the existence of "recursively and deeply to find
more"; the reason blame stopped at a particular commit is exactly because
there is no more---otherwise it wouldn't have stopped there but kept
digging deeper.

That is what I meant in the message you are responding to, quoted at the
top of this message.
