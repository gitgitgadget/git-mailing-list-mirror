From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t5800-*.sh: Intermittent test failures
Date: Sun, 04 Sep 2011 12:06:58 -0700
Message-ID: <7vpqjgyvn1.fsf@alter.siamese.dyndns.org>
References: <4E417CB4.50007@ramsay1.demon.co.uk>
 <CAGdFq_jv_T-x7VGqm_j-fDfeW6TsBG95=1TWn91Yk9B3TGZdsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 04 21:07:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0I26-0006eS-UT
	for gcvg-git-2@lo.gmane.org; Sun, 04 Sep 2011 21:07:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752884Ab1IDTHC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Sep 2011 15:07:02 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37599 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752531Ab1IDTHA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Sep 2011 15:07:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 37F5C310C;
	Sun,  4 Sep 2011 15:07:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2IN9BJk+924HMUASMAQatRUFZXE=; b=OyRNQj
	cUQitfGpLS70Onpg5FMwsq712YjADKQuw7w5OB5scbg+i7XUOeMyOxR+F8wRy2wC
	CXurNxylNP0wrKnpVze1UtVZGoQSs8vTFuTe6PFX10ijqhnk5cmP/Cx0ejkgkt9i
	Iir6RsFT1CpBUREeUDl4IOdZh5LTZ0sUpcC1o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Cp96SLCdm9ZbKh1mjlNwt7qFHy3hS+Wa
	s95YaJOzoJZSWLWuUsSOz2pPDnvNrRd7SGho+7WKJ27qh/wjGkDxz5lJ8KMiaBOX
	yo22Q/NalTI1SkqYTD7zPfzK9SJXnyO6XIFBB4hy/KXmUWS2iM/kz69Nr6SA5mbY
	AHBHaI+Mg3Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E389310B;
	Sun,  4 Sep 2011 15:07:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ACD18310A; Sun,  4 Sep 2011
 15:06:59 -0400 (EDT)
In-Reply-To: <CAGdFq_jv_T-x7VGqm_j-fDfeW6TsBG95=1TWn91Yk9B3TGZdsQ@mail.gmail.com> (Sverre
 Rabbelier's message of "Thu, 11 Aug 2011 23:39:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 10D5E61E-D729-11E0-836A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180695>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> Heya,
>
> On Tue, Aug 9, 2011 at 20:30, Ramsay Jones <ramsay@ramsay1.demon.co.uk> wrote:
>> The git-fast-import is hung in the read() syscall waiting for data which will
>> never arrive. This is because the git(fast-export) process, started by the above
>> git(push), executes (producing it's data on stdout) and completes successfully
>> and exits *before* the above git-fast-import process starts.
>>
>> I haven't looked to see how the git(fast-export)/git-fast-import processes are
>> plumbed together, but there seems to be a synchronization problem somewhere ...
>
> This seems odd, before the fast-export process is even started it's
> stdout are wired to the stdin of the helper (and thus the fast-import
> process). What indication do you have that fast-import hasn't started
> and that fast-export has finished?
>
> Also, you say git remote-test everywhere, but it should be git
> remote-testgit, typo?

FWIW, I have been seeing this every once in a while.
