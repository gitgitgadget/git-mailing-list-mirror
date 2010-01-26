From: Bill Lear <rael@zopyra.com>
Subject: Re: [PATCH 1/4] Add xmallocz()
Date: Tue, 26 Jan 2010 14:37:48 -0600
Message-ID: <19295.21148.182245.516321@blake.zopyra.com>
References: <1264530255-4682-1-git-send-email-ilari.liusvaara@elisanet.fi>
	<1264530255-4682-2-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Tue Jan 26 21:38:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZsAs-0005L4-GO
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 21:38:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187Ab0AZUhy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 15:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752156Ab0AZUhy
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 15:37:54 -0500
Received: from 75-27-130-60.lightspeed.austtx.sbcglobal.net ([75.27.130.60]:41060
	"HELO blake.zopyra.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1752148Ab0AZUhx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 15:37:53 -0500
Received: (qmail 25354 invoked by uid 500); 26 Jan 2010 20:37:52 -0000
In-Reply-To: <1264530255-4682-2-git-send-email-ilari.liusvaara@elisanet.fi>
X-Mailer: VM 8.1.0-beta under 23.1.1 (i386-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138073>

On Tuesday, January 26, 2010 at 20:24:12 (+0200) Ilari Liusvaara writes:
>Add routine for allocating NUL-terminated memory block without risking
>integer overflow in addition of +1 for NUL byte.
>...
> void *xmemdupz(const void *data, size_t len)
> {
>-	char *p = xmalloc(len + 1);
>+	char *p = xmallocz(len);
> 	memcpy(p, data, len);
> 	p[len] = '\0';
> 	return p;

Do you need the statement

 	p[len] = '\0';

any longer in the above?  If not, could you just do this:

void *xmemdupz(const void *data, size_t len)
{
	return memcpy(xmallocz(len), data, len);
}


??


Bill
