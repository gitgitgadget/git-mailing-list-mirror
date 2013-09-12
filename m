From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fwd: git-daemon access-hook race condition
Date: Thu, 12 Sep 2013 12:15:36 -0700
Message-ID: <xmqq4n9pq2av.fsf@gitster.dls.corp.google.com>
References: <CAPZPVFa=gqJ26iA6eQ1B6pcbTcQmmnXHYz6OQLtMORnAa5ec2w@mail.gmail.com>
	<CAPZPVFbJqbRGQZ+m3-EfahcYegPvVcS-jNTsCXxBqWUsLqyHkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 12 21:15:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKCMl-0007S2-44
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 21:15:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754599Ab3ILTPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 15:15:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36616 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753127Ab3ILTPk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 15:15:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 01711412A9;
	Thu, 12 Sep 2013 19:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GSuve/ayWagJbip6TZhOpzlDF/g=; b=sNlcLL
	znYvsom3Y4x27mZumUuD63tK4MmpYlrzQu/nKwgd1UykVsF2esJGtkiuOGyqrtwj
	cBP1o2PyNhkWjNPpKU0RUm+Hy6v5gjNYIr2Tb9J98JA63NsK2bovJXIZ9V7V/YC/
	uq79NAOjxCJmHqD/Xofsc21ogth8C4VPl8BJg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Pdh83qagFrpkZFZ8E3F+0vST/nq07n6t
	2mlMNtkbUtZP8vF8a6lrKEuYoYJQVla8F5eWhT81h/FLJkA9Zou4o5cMVmtqafWq
	tVblPduLV2fWi1fDdojAUT/dVIERdAUT1pWi0MV7gT4bjoAov77CiFQFJsuegCr/
	dasLihUqj5k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA6FE412A6;
	Thu, 12 Sep 2013 19:15:39 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4AA1E41296;
	Thu, 12 Sep 2013 19:15:38 +0000 (UTC)
In-Reply-To: <CAPZPVFbJqbRGQZ+m3-EfahcYegPvVcS-jNTsCXxBqWUsLqyHkg@mail.gmail.com>
	(Eugene Sajine's message of "Thu, 12 Sep 2013 14:51:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B53663D0-1BDF-11E3-BCBC-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234675>

Eugene Sajine <euguess@gmail.com> writes:

> Is it possible to have access-hook to be executed after receive?

The whole point of access-hook is to allow it to decide whether the
access is allowed or not, so that is a non-starter.

A notification _after_ successful push update is usually done via
the post-receive hook in the receiving repository, I think.
