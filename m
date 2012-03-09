From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Passing commit IDs to git-archive
Date: Fri, 09 Mar 2012 14:34:07 -0800
Message-ID: <7vhaxx4d5s.fsf@alter.siamese.dyndns.org>
References: <8c6d921d-9e8e-4caf-bc04-b1d2cfdd294f@mail>
 <8fb14091-99dc-4383-9cab-5bf508e0a554@mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 23:34:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S68O8-0003N3-MI
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 23:34:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758078Ab2CIWeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 17:34:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41711 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755735Ab2CIWeK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 17:34:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2EBC0710D;
	Fri,  9 Mar 2012 17:34:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4Wpi8oqwEOeoqsacLgutNdFCM4g=; b=Zb5OQO
	3cGh55CIKl2e9XeQqHpWAOn/8Rpeik2qIQvd1IoBLORgb/zDGtESujOkDeXDiiAk
	CoPWdkEJATpS4ts0WxP+gMxbHQzTzdJhzTEC3KF9DfsmDMrzmWiDHxQ96oYKbvpn
	HHb5Fm8yexKJnAHjLw7xSl2SADcMFPgwJ3DwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BZtiAAekdG3G1VQxYHU7ZZCH6EsnPhGX
	lyNE4zRFsgkXjwhXeTivWAv1v+004/Mf+rPVbVBdW1JSeBH8DrxI0ujOH+eod7JW
	NoV3uw9hWpkauNdn+l8NpXZDM929gFhmPUraYaGWo+nb8G2O7RRHGBBCe2mpPb8W
	geAcJvdBII0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 24371710C;
	Fri,  9 Mar 2012 17:34:09 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9438D7108; Fri,  9 Mar 2012
 17:34:08 -0500 (EST)
In-Reply-To: <8fb14091-99dc-4383-9cab-5bf508e0a554@mail> (Stephen Bash's
 message of "Fri, 09 Mar 2012 17:14:05 -0500 (EST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FC486FBC-6A37-11E1-8045-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192748>

Stephen Bash <bash@genarts.com> writes:

> Unfortunately I just attempted
>
>   warp:bar bash$ git archive --remote=file:///Users/bash/Development/foo \
>                              --output=test.tgz 3b9e49b \
>                              path/to/subdir
>
> Thoughts?  Thanks in advance!

If you are always fetching from that same location, perhaps doing
this only once

	git clone file:///...

and then every time you want to use the test.tgz, do something like

	git fetch
        git archive --output=test.tgz 3b9e49b path/to/subdir

or something like that?
