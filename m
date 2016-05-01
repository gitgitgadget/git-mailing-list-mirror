From: Mike Hommey <mh@glandium.org>
Subject: [PATCH v3 0/6] connect: various cleanups
Date: Sun,  1 May 2016 15:02:47 +0900
Message-ID: <1462082573-17992-1-git-send-email-mh@glandium.org>
Cc: gitster@pobox.com, tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 08:03:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awkTS-00082c-VB
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 08:03:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbcEAGDH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 May 2016 02:03:07 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:33614 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750885AbcEAGDA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 02:03:00 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <glandium@glandium.org>)
	id 1awkSz-0004gy-QR; Sun, 01 May 2016 15:02:53 +0900
X-Mailer: git-send-email 2.8.1.16.g58dac65.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293143>


On Fri, Apr 29, 2016 at 09:58:37AM -0700, Junio C Hamano wrote:
> So I would suggest restructuring this series to do
> 
>  * 2/3 (DIAG consolidation)
>  * refactoring in 3/3 but not s/static/extern/
> 
> and in optional follow(s)-up, do
> 
>  * s/static/extern/ and update to *.h in 3/3
> 
>  * 1/3, but I do not think it is necessary for users of
>    prepare_ssh_command()

I went a little further on the restructuring and did some more cleanup.
This could probably go even further, but that'd be well out of the scope
I started those patches for :)

The order in which the changes have been done in this new series is
debatable, but I thought the split in smaller parts made things easier
to review, even if they could have been done in different orders.

I'm leaving the optional follows-up for now. I'll work around the functions
being static somehow on my end.


Mike Hommey (6):
  connect: remove get_port()
  connect: uniformize and group CONNECT_DIAG_URL handling code
  connect: only match the host with core.gitProxy
  connect: pass separate host and port to git_tcp_connect and
    git_proxy_connect
  connect: don't xstrdup target_host
  connect: move ssh command line preparation to a separate function

 connect.c             | 184 ++++++++++++++++++++++----------------------------
 t/t5500-fetch-pack.sh |  25 ++++---
 2 files changed, 95 insertions(+), 114 deletions(-)

-- 
2.8.1.16.g58dac65.dirty
