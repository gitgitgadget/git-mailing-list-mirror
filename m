From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] git add: notice removal of tracked paths by default
Date: Tue, 19 Apr 2011 14:41:23 -0700
Message-ID: <7voc41537g.fsf@alter.siamese.dyndns.org>
References: <7v1v0y59tv.fsf@alter.siamese.dyndns.org>
 <BANLkTin4iVLzga6gFAh+x8nRTKuVTTFPqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 23:41:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCIfy-000229-2H
	for gcvg-git-2@lo.gmane.org; Tue, 19 Apr 2011 23:41:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754151Ab1DSVld (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2011 17:41:33 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58910 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752382Ab1DSVlc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2011 17:41:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 33B4543AB;
	Tue, 19 Apr 2011 17:43:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lDDEeattL6B/4yz1Qd6YVde6oow=; b=sl0g8o
	ker188kLaB2VgzdPzLovKtUXzumhU23H+i5kIOdHt9FjfPhfkSS3vikD8Wu9cCPF
	Gpy+koq4zQWwdcJfEfkJPaBkiGK9qNpfByFtMyrtgW4H0BbeBIypMp8kXkkHC7Gs
	RboPvwFBoc6oSLpU1dK8EKX3q0PGIFNiVLQec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sI1lZmIhOmEDUDlwagcvQX3tVLoiO9HB
	1XPFQS+YgnKRGrOeqeNnmjlSm3gTUGIG8yiLTIOxXOT3PIEAjSS7PhkUEMpuT1bu
	1N0BpiGNIRfe/UWUuv3oewNem+p0KNvxgWbt0MOT/3mnIbRwX/LquAAPrlb2RYdS
	lQEsBBGWbqc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1208A43AA;
	Tue, 19 Apr 2011 17:43:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3068843A9; Tue, 19 Apr 2011
 17:43:25 -0400 (EDT)
In-Reply-To: <BANLkTin4iVLzga6gFAh+x8nRTKuVTTFPqA@mail.gmail.com> (Sverre
 Rabbelier's message of "Tue, 19 Apr 2011 21:46:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 10454342-6ACE-11E0-A007-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171818>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> Is there a way to add disable this somehow? I don't think we have a
> '--no-update', do we?

If we need to be able to disable this, then we are probably better off not
doing this change. After all, adding -A on the command line is easy.

The change makes sense only if nobody wants to do "only addition and
modification".

I have a strong feeling that the current "git add $path" semantics came
primarily from historical implementation and pure inertia, and not from a
well thought out design.  After all, when you are saying "git add ." (or
"git add dir/"), you are saying that you want to take what you have in
that directory as a whole, except for whatever is excluded with your
well-maintained .gitignore file. It felt very unnatural that the command
excluded removal without the "-A" option when I tried to be in that
mindset.

But as I said, I do not have a strong opinion for this change, other than
"if we need this optional, then it is not worth doing this".
