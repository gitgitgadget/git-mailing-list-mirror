From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v3] add a commit.verbose config variable
Date: Thu, 10 Mar 2016 13:46:29 -0800
Message-ID: <xmqqy49qc8ga.fsf@gitster.mtv.corp.google.com>
References: <0102015361e5441b-bbc448b5-7307-451d-a951-f016f7ae4b1d-000000@eu-west-1.amazonses.com>
	<xmqq7fhadnkv.fsf@gitster.mtv.corp.google.com>
	<CAFZEwPP5_rBKH_=0pv_3PszLYtnznXeGJg1+yjwbiH0m_BqdZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 22:47:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ae8Q6-0000kp-OR
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 22:46:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932638AbcCJVqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 16:46:35 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57648 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932620AbcCJVqc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 16:46:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9149F49D43;
	Thu, 10 Mar 2016 16:46:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l0N73KTzGVlfFlC3sRACILqATgY=; b=NGSQeb
	ADF/HcDV4nCqPM1eVBGYjEXgCD6DIauAJfsMr4ezzzMqlTSTaQlX76y1apPx7U2u
	nJbx/xy6aBM7l7oUsjke8oozp+/v1pjdeQMmmqmj2EmbJ8qXYZe/seiU5i3gJEh/
	iTSKWqOtkd1Ss6NptZowP2OvbFQRSeilvs/MM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PyBA0FoK1YFrAZe0cCgX1g4cpxlc/8hi
	N1uSX6nEE+/xxL5o461/Lgn6LFFlOO553Y3nUYEHFLPAOv8GK+9upq2KeyB80pPw
	HhZ9XkllG3ejO/trFxv4Rq6xqQshpyCoJrFEI7zcruFUCe0sjZ0rPe6S+dtZYeLP
	MEzOqKn2YDQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8955849D42;
	Thu, 10 Mar 2016 16:46:31 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E9AA749D41;
	Thu, 10 Mar 2016 16:46:30 -0500 (EST)
In-Reply-To: <CAFZEwPP5_rBKH_=0pv_3PszLYtnznXeGJg1+yjwbiH0m_BqdZQ@mail.gmail.com>
	(Pranit Bauva's message of "Fri, 11 Mar 2016 03:08:51 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8CEC587E-E709-11E5-935B-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288648>

Pranit Bauva <pranit.bauva@gmail.com> writes:

> On Fri, Mar 11, 2016 at 3:04 AM, Junio C Hamano <gitster@pobox.com>
> wrote:
>> But doesn't this belong to git_commit_config(), not
>> git_STATUS_config()?  Should "commit.verbose" make output from "git
>> status" verbose?
>
> True. It should belong to git_commit_config(). My bad. But
> surprisingly this code works. I have no idea why. I will update the
> Patch and I have also finished writing test so I will include that
> also.

If that is surprising to you, that indicates that you only tested
"commit" and not "status", I think.  If you choose commit.verbose to
apply only to "commit", but not "status", then your test should
cover both commands, i.e. when the configuration is set to true, the
default verbosity level for "git commit" should be raised, and the
verbosity level for "git status" should not be--both must be
verified in your test script.
