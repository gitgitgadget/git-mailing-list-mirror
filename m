From: Michael Blume <blume.mike@gmail.com>
Subject: TTY tests are unnecessarily suppressed under Mac OS
Date: Wed, 12 Nov 2014 14:25:52 -0800
Message-ID: <CAO2U3QhB6rSfJn5ODE8-n2XWuBw8BePqDpQbNdx6LyWy=OFbcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 12 23:26:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XogMj-0002Hw-Jh
	for gcvg-git-2@plane.gmane.org; Wed, 12 Nov 2014 23:26:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752539AbaKLW0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2014 17:26:14 -0500
Received: from mail-oi0-f52.google.com ([209.85.218.52]:47958 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513AbaKLW0N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2014 17:26:13 -0500
Received: by mail-oi0-f52.google.com with SMTP id u20so9277842oif.39
        for <git@vger.kernel.org>; Wed, 12 Nov 2014 14:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=+0T5qGYKs87ASjuENzIk6H5879RXCvsckXlYuyyhuso=;
        b=K8e6Cxhrn1jfFFcpCHsm/zqKNGkWha8H7jUo/6rxOZ34H3ERs8ybyoLcxqZgg1y3Om
         IzFG0+43fah6NQBjlVRSy9FW8MY0fSs4Ey+/8W3s8aetp9lSPMZ+FH32TTrQUD6Z/4Sy
         e30kRj+7Z4ZCsm51zetc0WRv0RIhyhpcekWOKSe4nwWQqv1IwjDFSZxzlhs0DRMr1Rfz
         nOZI8qARuV49wOB+V+3gJt/iLOqDjUHxHDSHC46zT4EtkziYN4ENb3eS98AOmiW3ql6J
         qhpU+b8xRsFVDLIbOUbOO++rxcIGts7lACDd3KXtgoDyusVxqgHQBxTCcyGZLE3A+PB8
         6uAw==
X-Received: by 10.60.137.193 with SMTP id qk1mr9187408oeb.4.1415831172683;
 Wed, 12 Nov 2014 14:26:12 -0800 (PST)
Received: by 10.202.18.132 with HTTP; Wed, 12 Nov 2014 14:25:52 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>From lib_terminal.sh:

# Reading from the pty master seems to get stuck _sometimes_
# on Mac OS X 10.5.0, using Perl 5.10.0 or 5.8.9.
#
# Reproduction recipe: run
#
# i=0
# while ./test-terminal.perl echo hi $i
# do
# : $((i = $i + 1))
# done
#
# After 2000 iterations or so it hangs.
# https://rt.cpan.org/Ticket/Display.html?id=65692
#
test "$(uname -s)" != Darwin &&

I tried the reproduction recipe on my mac and couldn't reproduce, so
it may make sense to take this switch out? In any case, I've set my
automated mac build to include TTY tests
