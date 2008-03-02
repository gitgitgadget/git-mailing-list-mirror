From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix git reset --abort not restoring the right commit
 under some conditions
Date: Sat, 01 Mar 2008 19:57:34 -0800
Message-ID: <7vmyphvkup.fsf@gitster.siamese.dyndns.org>
References: <7vod9y4xcn.fsf@gitster.siamese.dyndns.org>
 <1204367534-28204-1-git-send-email-mh@glandium.org>
 <7vmyphx3l3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sun Mar 02 04:58:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVfLY-0002OY-RF
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 04:58:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660AbYCBD5m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 22:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751686AbYCBD5m
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 22:57:42 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43536 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547AbYCBD5m (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 22:57:42 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 707131FBA;
	Sat,  1 Mar 2008 22:57:40 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id CA3031FB9; Sat,  1 Mar 2008 22:57:36 -0500 (EST)
In-Reply-To: <7vmyphx3l3.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 01 Mar 2008 18:27:36 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75719>

Junio C Hamano <gitster@pobox.com> writes:

> Mike Hommey <mh@glandium.org> writes:
>
>> Previously, --abort would end by git resetting to ORIG_HEAD, but some
>> commands, such as git reset --hard (which happened in git rebase --skip,
>> but could just as well be typed by the user), modify ORIG_HEAD.
>>
>> Just use the orig-head we store in $dotest instead.
>
> What happens if we are not using $dotest but .dotest?

Ah, there is an assignment to that variable in that case.  Ok.

The script really needs an overhaul someday.  It got unreadable over
time.
