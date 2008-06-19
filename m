From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make git_dir a path relative to work_tree in
 setup_work_tree()
Date: Wed, 18 Jun 2008 20:03:13 -0700
Message-ID: <7vr6auw2ha.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0806181949160.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Jun 19 05:04:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9ARn-0006dH-9E
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 05:04:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755912AbYFSDDa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 23:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755855AbYFSDDa
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 23:03:30 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59515 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755616AbYFSDD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 23:03:29 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BBE8D1795A;
	Wed, 18 Jun 2008 23:03:21 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 14BEB17956; Wed, 18 Jun 2008 23:03:15 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.00.0806181949160.19665@iabervon.org> (Daniel
 Barkalow's message of "Wed, 18 Jun 2008 21:55:45 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4681D67A-3DAC-11DD-BC18-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85443>

Daniel Barkalow <barkalow@iabervon.org> writes:

>  	if (initialized)
>  		return;
> -	work_tree = get_git_work_tree();
> +	work_tree = xstrdup(make_absolute_path(get_git_work_tree()));

Might be a nice try, but Oops, I suspect.

Doesn't the presense of "if (!work_tree..." below tell you that the
function you are calling can legitimately return NULL?
