From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Using git-replace in place of grafts -- and publishing
 .git/refs/replace between repos?
Date: Sat, 15 Sep 2012 10:21:38 -0700
Message-ID: <7vvcffyzfh.fsf@alter.siamese.dyndns.org>
References: <CACffvTp4qnHc3RHKDotEfvshVDqGtTX6eh6Fr-bmJSMUvTFN6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Chanters <david.chanters@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Sep 15 19:21:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCw3x-0005wA-CT
	for gcvg-git-2@plane.gmane.org; Sat, 15 Sep 2012 19:21:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754829Ab2IORVl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2012 13:21:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64063 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754360Ab2IORVk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2012 13:21:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 271028EA6;
	Sat, 15 Sep 2012 13:21:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jWXLTTH9e8UAGQif9xHLRtxDPpc=; b=N52hee
	5Yx9MIxsyeftb4h7ykXhpFUDeKnux6WUVOiOEEzrmOktTXy4Zv2obJhUMG8Bpf1v
	FElPAQL62Ju8A0ON14Pyxk6JykjKhPAaIESEHN8rVivp0ErPgtF3xHX2RgJBCc7+
	nH+KcH8YriPanDZoom2TzLXqHMSOsIfP91tg8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QD2ZNsEEL7HiOgRfkl7P8xuC6ZnWduak
	ujknEq+HbAs/yGz3K/61MUaXxM7vm7MOEMJke2L9fRv57Dx6Gli/3ZU6Jazko/qh
	NKxkTVPN1T+ZYyWwF0FsnkO+0o56D3/k0XG5aH5It/p7v2UBmR7G6yavb32TmDbe
	ywIEBHp7R1Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 13D0D8EA5;
	Sat, 15 Sep 2012 13:21:40 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 87A1E8EA4; Sat, 15 Sep 2012
 13:21:39 -0400 (EDT)
In-Reply-To: <CACffvTp4qnHc3RHKDotEfvshVDqGtTX6eh6Fr-bmJSMUvTFN6g@mail.gmail.com> (David
 Chanters's message of "Sat, 15 Sep 2012 13:02:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CF763BC4-FF59-11E1-936C-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205566>

David Chanters <david.chanters@googlemail.com> writes:

> 1.  I thought the replace data in .git/refs/replace was published when
> I did "git push" so that others could use this information as a
> base-point, yet it seems not to be the case.  How do I publish this?

If you don't tell it what to push, the command will just update the
branches.  You can tell "git push" what you want to push explicitly,
e.g. 

    $ git replace -l ;# to learn what replacement I want to send
    77d5ba8477eb90509e79dbcf63814a3dfdefb906
    $ git push origin refs/replace/77d5ba8477eb90509e79dbcf63814a3dfdefb906

> 2.  If I do publish it, are there any caveats with that?  i.e.,
> because the replace data will likely point to a repo which in my
> working checkout I added with "git-remote", is that going to be a
> problem?

That is between you and other project participants.  They may not
want to see replacement in their project in the first place.

Assuming that they do, pushing the replacement ref makes the
replacing object available in the pushed-into repository, so
they will *not* rely on your repository.
