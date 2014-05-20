From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GIT and large files
Date: Tue, 20 May 2014 10:18:04 -0700
Message-ID: <xmqqmwec1i9f.fsf@gitster.dls.corp.google.com>
References: <C755E6FBF6DC4447BEF161CE48BDE0BD2F0CD53E@XMBVAG73.northgrum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: "Stewart\, Louis \(IS\)" <louis.stewart@ngc.com>
X-From: git-owner@vger.kernel.org Tue May 20 19:18:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wmng7-0001Vu-8J
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 19:18:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753571AbaETRSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 13:18:11 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53009 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752851AbaETRSK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 13:18:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8602A17D3E;
	Tue, 20 May 2014 13:18:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B0dnWx/lCKGYDdiAIkXmK/URXGU=; b=iwfEW/
	pRJ3KJAvIVdOhbc2BgB45ScR8VcWzEc4oUBmwPltk+WfZThspK3LEWNpJcnzoN3L
	qpLIHtg2mj11kNXfYG5tzlH/Lfzf2i5IAP02AUz6LC7E4YZoMGEOMdQ3dB8S5dsB
	sBNo74eV8PBVIMZRy/l+LF3GeLDaRM9Jq5/48=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n4kt96yLJW/is/M0Mua+4eqTZhbeCjE6
	D0OpWlns+0uY8nvC9zQIMRAKN2DQJSV009dejama3XcZGC56WmQC1NITbM/9ZQIB
	zvwTk0t1PJAFIMfoMoXdHBJ9v48szDImkqWd14P4mjjZJCYWZ1gbLUbg3k4pgfGW
	rEFICP5l+pQ=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7C1D317D3D;
	Tue, 20 May 2014 13:18:09 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 47C4E17D3A;
	Tue, 20 May 2014 13:18:06 -0400 (EDT)
In-Reply-To: <C755E6FBF6DC4447BEF161CE48BDE0BD2F0CD53E@XMBVAG73.northgrum.com>
	(Louis Stewart's message of "Tue, 20 May 2014 15:37:41 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B5288BD4-E042-11E3-8DD9-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249706>

"Stewart, Louis (IS)" <louis.stewart@ngc.com> writes:

> Can GIT handle versioning of large 20+ GB files in a directory?

I think you can "git add" such files, push/fetch histories that
contains such files over the wire, and "git checkout" such files,
but naturally reading, processing and writing 20+GB would take some
time.  In order to run operations that need to see the changes,
e.g. "git log -p", a real content-level merge, etc., you would also
need sufficient memory because we do things in-core.
