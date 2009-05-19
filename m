From: John Koleszar <john.koleszar@on2.com>
Subject: Re: [PATCH 4/3] Introduce 'convert_path_to_git()'
Date: Tue, 19 May 2009 09:31:48 -0400
Organization: On2 Technologies
Message-ID: <1242739908.17490.5.camel@cp-jk-linux.corp.on2.com>
References: <alpine.LFD.2.01.0905141341470.3343@localhost.localdomain>
	 <alpine.LFD.2.01.0905141342520.3343@localhost.localdomain>
	 <alpine.LFD.2.01.0905141346440.3343@localhost.localdomain>
	 <alpine.LFD.2.01.0905151156090.3343@localhost.localdomain>
	 <7vy6sxpn2q.fsf@alter.siamese.dyndns.org>
	 <loom.20090519T120452-71@post.gmane.org>
Reply-To: john.koleszar@on2.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jens Kilian <jjk@acm.org>
X-From: git-owner@vger.kernel.org Tue May 19 15:39:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6PXr-0001bp-KM
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 15:39:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754265AbZESNjl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 09:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753776AbZESNjl
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 09:39:41 -0400
Received: from mail.on2.com ([66.162.65.131]:35444 "EHLO on2.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753424AbZESNjk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 09:39:40 -0400
X-Greylist: delayed 407 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 May 2009 09:39:40 EDT
In-Reply-To: <loom.20090519T120452-71@post.gmane.org>
X-Mailer: Evolution 2.24.5 
X-On2-MailScanner-i: Found to be clean
X-On2-MailScanner-From: john.koleszar@on2.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119528>

Haven't been following this thread, so I don't know what the context is
here, but the brain teaser caught my eye.

On Tue, 2009-05-19 at 08:20 -0400, Jens Kilian wrote:
> Junio C Hamano <gitster <at> pobox.com> writes:
> > "Ugly" is not quite the word I am looking for.  "My gut feels that there
> > has to be a way to write this more cleanly, but I am frustrated that I
> > cannot come up with one" might be the word...
> 
> How about this:
> 
> #include <stdio.h>
> 

-#define MAGIC(type)  ((~(type)0 / (type)0xff) << 7)
+#define MAGIC(type)  ((type)(~(type)0 / 0xffU << 7))

> #define TEST(type) printf(#type " %llx\n", (unsigned long long)MAGIC(type))
> 
> int
> main(void)
> {
> /*TEST(unsigned char);  Doesn't work, and I'm too lazy to find out why. */
>   TEST(unsigned int);
>   TEST(unsigned long);
>   TEST(unsigned long long);
>   return 0;
> }
> 

--John
