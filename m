From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Failure cloning from a separate-git-dir repository
Date: Sun, 21 Aug 2011 11:51:43 -0700
Message-ID: <7vippqy4w0.fsf@alter.siamese.dyndns.org>
References: <6csv47te4qv41ni53q0kf1fne0a4e1grnm@4ax.com>
 <CACsJy8AavETJb-Lm0Qd6Sz54zYbgvDUWmf+uXYTxO3+iYNHvoA@mail.gmail.com>
 <p800579qgdoocnq388veh5gpjbu7r9ph52@4ax.com>
 <CACsJy8A4kvjn5Bgo6FtS+x4z=CRz8ctoDHh7D8XV3frOjDVfbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Richard Tibbitt <gitlist@lazyprune.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 21 20:51:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvD7f-0002Kv-Oy
	for gcvg-git-2@lo.gmane.org; Sun, 21 Aug 2011 20:51:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752319Ab1HUSvq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Aug 2011 14:51:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42277 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752021Ab1HUSvq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Aug 2011 14:51:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 295A549D9;
	Sun, 21 Aug 2011 14:51:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2Jw4b/4ejxGYckX8g9r8KcAkEyc=; b=I5LreQ
	R0lBoQ1UOftsKDMJdKOp/KdeQiJmjCvcpCIiRW6ZO2sMqemSjlFJgpGnZaRY/m20
	/Wf1e84O+5THQsLWkY6iUxDkDUsa6X5Oe0ulgNj2iOtjK7MuPMblftlgonHOA9Io
	OWibAl3a8FUxP9m6HkqsmVi7kh7964QHTUICw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IjxbYGUHLxJe6AXIV4UNpfaF+GXOe4F2
	T9fotlJsgEr07+Sl+FizdCbJfsp72qXLC8Hu83kGhX0gy0Bp76/tN/urLDxxg778
	srXbGTjN4aVIxCJig062GMPWqeHw/NMQyRRQW+GCaEFh2MfUx19g9o6z6F2h9jmt
	/+hflaZ8oDo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F94249D8;
	Sun, 21 Aug 2011 14:51:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A6ED749D7; Sun, 21 Aug 2011
 14:51:44 -0400 (EDT)
In-Reply-To: <CACsJy8A4kvjn5Bgo6FtS+x4z=CRz8ctoDHh7D8XV3frOjDVfbw@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Sun, 21 Aug 2011 10:27:44 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9DA78BFA-CC26-11E0-9A70-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179806>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Sun, Aug 21, 2011 at 1:56 AM, Richard Tibbitt <gitlist@lazyprune.com> wrote:
>> call git clone repo2git\.git clone2
>> fatal: repository 'repo2git\.git' does not exist
>>
>> I guess this must be a peculiarity of msysgit on windows.
>
> Yes. Try "call git clone repo2git/.git clone2" (forward slash). The
> forward slash is hard coded some places in git-clone. I just want to
> make sure you dont hit another problem.

As "fetch from bundle" (2e0afaf (Add git-bundle: move objects and
references by archive, 2007-02-22)) predates the "gitdir:" support
(b44ebb1 (Add platform-independent .git "symlink", 2008-02-20)) by a wide
margin, I wouldn't be surprised at all if the logic went "If the name can
be stat()ed and is a regular file, it must be a bundle. Otherwise it is a
local clone if it is a directory. All else ask the transport and see what
it says".

Why can't it be "git clone repo2git clone2" in the first place?
