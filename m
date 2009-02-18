From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 03/10] config: Make git_config() more flexible
Date: Wed, 18 Feb 2009 13:13:11 -0800
Message-ID: <7viqn7v47s.fsf@gitster.siamese.dyndns.org>
References: <1234878776-13250-1-git-send-email-felipe.contreras@gmail.com>
 <1234878776-13250-2-git-send-email-felipe.contreras@gmail.com>
 <1234878776-13250-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 22:15:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZtkn-0006yd-Je
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 22:14:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754254AbZBRVNV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 16:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752782AbZBRVNV
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 16:13:21 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53341 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756887AbZBRVNU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 16:13:20 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 261AF9A9FB;
	Wed, 18 Feb 2009 16:13:18 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CC68C9A9F9; Wed,
 18 Feb 2009 16:13:13 -0500 (EST)
In-Reply-To: <1234878776-13250-3-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Tue, 17 Feb 2009 15:52:49 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F693D3AA-FE00-11DD-BF34-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110578>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Currently git_config() returns an error if there is no repo config file
> available (cwd is not a git repo); it will correctly parse the system
> and global config files, but still return an error.

Currently it does???

Here is what I get from using the command from master and next:

    $ cd /var/tmp
    $ ls -d /.git /var/.git /var/tmp/.git /var/tmp/config
    ls: /.git: No such file or directory
    ls: /var/.git: No such file or directory
    ls: /var/tmp/.git: No such file or directory
    ls: /var/tmp/config: No such file or directory
    $ git config -l >/dev/null ; echo $?
    0
    $ git config alias.co; echo $?
    checkout
    0

I have $HOME/.gitconfig (where the alias comes from) and no system wide
configuration file.

Also the patch is mistitled.  Whatever you are trying to say about the
current problem which I do not seem to get, and whatever different
behaviour from the current one you are trying to implement (which is not
quite clear from the above log message), it is not about making it more
flexible.

The patch text suggests you are trying to change the function's exit
status so the title would be "git-config: report errors correctly in its
exit status", but it is unspecified in your commit log message what
definition of "correctly" you are using in this patch.
