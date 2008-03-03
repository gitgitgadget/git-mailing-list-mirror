From: Gerrit Pape <pape@smarden.org>
Subject: Re: [PATCH] Fix random crashes in http_cleanup()
Date: Mon, 3 Mar 2008 10:01:41 +0000
Message-ID: <20080303100141.15600.qmail@e81d07a86798f7.315fe32.mid.smarden.org>
References: <20080302200309.GA2070@glandium.org> <1204489713-8696-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com,
	Daniel Barkalow <barkalow@iabervon.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Mon Mar 03 11:02:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW7Uf-0006bC-7q
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 11:02:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755833AbYCCKBX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Mar 2008 05:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755539AbYCCKBW
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 05:01:22 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:42927 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754933AbYCCKBV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 05:01:21 -0500
Received: (qmail 15601 invoked by uid 1000); 3 Mar 2008 10:01:41 -0000
Content-Disposition: inline
In-Reply-To: <1204489713-8696-1-git-send-email-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75912>

On Sun, Mar 02, 2008 at 09:28:33PM +0100, Mike Hommey wrote:
> For some reason, http_cleanup was running all active slots, which cou=
ld
> lead in situations where a freed slot would be accessed in
> fill_active_slots. OTOH, we are cleaning up, which means the caller
> doesn't care about pending requests. Just forget about them instead
> or running them.

Hi, I can confirm that this fixes the segfault we managed to reproduce,
but didn't look deeper into the changes.

There's a warning when compiling http.c, trivial to fix:

      CC http.o
  http.c: In function =E2=80=98http_cleanup=E2=80=99:
  http.c:288: warning: unused variable =E2=80=98wait_url=E2=80=99

Thanks!, Gerrit.
