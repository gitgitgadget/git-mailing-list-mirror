From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: git config --unset does not remove section
Date: Sun, 21 Oct 2012 08:46:10 +0200
Message-ID: <CAB9Jk9C_b_PScm3vEdvxsjqNHpTbz7OTTdFeFey7Sdb+M5gYFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 21 08:46:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPpIl-0003XZ-GN
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 08:46:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541Ab2JUGqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 02:46:11 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:42475 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806Ab2JUGqK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2012 02:46:10 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so871608dak.19
        for <git@vger.kernel.org>; Sat, 20 Oct 2012 23:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=l+kCB+YfG7m3hC+oImlEvqrfTN0jfWh52hrQMhFKhP0=;
        b=IQGcr3DLb9b65U3+Yg/DSIjybLSBJk4k8P3FiMZxYmLPEZ501UBqwIh2AkOOLEnAd4
         Vc7GyXW3C9MhrOKbO9fFWP9DyHKXRJAMpDEeZwALLDHlh5e+xNATCbKtiPnQvfkKzJBS
         8JkOMADlJ8sJWVrRGTh5jYhLZI2UkGW9PzeyeLPQePJQkFbSlMfJ9gAJznlQtdrKQEy8
         /YvC8d8z/YhSo6nNynPn+saCSzryCs9Efs1Ece4juxb7O1+Dckqa6dDXkV9iB0ABpk0W
         /VFM0qYZkW6S9FXlysZL7RQaH6Vc7COhS2Fd2i11AqeqYbiBjuRkDvaa6+/5ibgwA2ZA
         Srcg==
Received: by 10.68.200.72 with SMTP id jq8mr20151655pbc.38.1350801970500; Sat,
 20 Oct 2012 23:46:10 -0700 (PDT)
Received: by 10.67.3.101 with HTTP; Sat, 20 Oct 2012 23:46:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208113>

Hello,

git config --unset does not remove the section in the configuration
file when the removed key is the last one, leaving then an empty
section that is lo longer used. E.g.:

    git config foo.bar true

creates:

    [foo]
	bar = true

then:

    git config --unset foo.bar

changes the section into:

    [foo]

Another git config foo.bar true changes the config file into:

    [foo]
    [foo]
	bar = true

Having two sections with the same name clutters the config file.

-Angelo Borsotti
