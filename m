From: Bill Lear <rael@zopyra.com>
Subject: Support for config wildcards
Date: Tue, 13 Mar 2007 10:47:23 -0600
Message-ID: <17910.54683.651029.884390@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 13 17:47:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRAAC-00018p-F4
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 17:47:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030792AbXCMQrk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Mar 2007 12:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030791AbXCMQrk
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Mar 2007 12:47:40 -0400
Received: from mail.zopyra.com ([65.68.225.25]:61842 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030792AbXCMQrj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2007 12:47:39 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l2DGlaS26353;
	Tue, 13 Mar 2007 10:47:36 -0600
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42133>

I would like to use our update hook to send email to recipients based
on a branch name pattern.  For example, the "abc" team would get email
for all updates to branches that start with the word "abc".

I would like to write something like this in the config file:

[hooks.mail.recipients]
        xyz.pickle = me, you, betty-sue
        xyz* = joe, jaya, julie
        abc* = mark, nancy, svetlana
        taug* = sridhar, pete, joe
        * = me, you, big-boss

Then, in the update hook, do something like this (very
pseudo-code-ish):

    for key, value in $(git config --get-regexp hooks.mail.recipients*); do
        key=${key#hooks.mail.recipients}
        if $(matches $key $branch); then
            recipients=$value
            break
        fi
    done

Which would allow me to change the mailing list recipients based
on the branch without having to update the update hook each time.

But, apparently at least the '*' and '.' characters are not allowed as
keys, and I can't seem to escape them.

Is there a way to do this sort of thing that I am missing?


Bill
