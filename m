From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] attr.c: add push_stack() helper
Date: Wed, 08 Jun 2016 17:15:15 -0700
Message-ID: <xmqqlh2fjjzg.fsf@gitster.mtv.corp.google.com>
References: <20160608225818.726-1-gitster@pobox.com>
	<20160608225818.726-2-gitster@pobox.com>
	<CAGZ79ka+BXOAMr7JxJXmhsmXTwTcdidJ72=9mbCkHiycj-t6AQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 02:15:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAnd6-0001xx-Np
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 02:15:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbcFIAPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 20:15:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50823 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751016AbcFIAPT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 20:15:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 89FBC22913;
	Wed,  8 Jun 2016 20:15:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s5m417vkcgUb8353yzs1L4uk3e8=; b=OPvsb+
	1MRWMcBTeUr2WNej966+Z8Qli8S78sJ1SaEOrTUOmO0shhGnPp4K0U7M7HlPsueB
	GMJ8Fx8m7eFm1udpnMc0eZBtNIFSvbAFYBYYuUas4Sbh2liawwW+1ocqyj2xnRHX
	H4fUA5Hf9ZpD1UGCHY3zdFevsoXqPdRikat2g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z4Nh5dD8bUv7u7HgauQ9kHTUvST1WiXd
	CXcJ2Ap23dG1ZjuY7brRXCJOrhwKsKO5/AyFloG5tmeGY4Hhh1sNZJct75XHgTHJ
	rmS6pV0fXOCmNadrm7C4ScHJeMgKlXK3yCV/vZzPKF6eyrmxiVuAaCjEpaaX54QB
	ydtetMM8cZ8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 80DAB22912;
	Wed,  8 Jun 2016 20:15:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 08F6122911;
	Wed,  8 Jun 2016 20:15:16 -0400 (EDT)
In-Reply-To: <CAGZ79ka+BXOAMr7JxJXmhsmXTwTcdidJ72=9mbCkHiycj-t6AQ@mail.gmail.com>
	(Stefan Beller's message of "Wed, 8 Jun 2016 16:43:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3E75459C-2DD7-11E6-9BDB-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296865>

Stefan Beller <sbeller@google.com> writes:

All of your questions is about !origin vs !*origin.  This applies to
the code in 'master', not specific to jc/attr topic's improvements.
It is how the prepare_attr_stack() tells where the .gitattributes
for the top-level directory is when popping the elements for other
directory hierarchy we have left (origin && !*origin is the root
level). !origin denotes entries that did not come from in-tree files
(i.e. $GIT_DIR/info/attributes, built-in ones, etc.).
