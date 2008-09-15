From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: CGit and repository list
Date: Tue, 16 Sep 2008 00:04:01 +0200
Message-ID: <8c5c35580809151504r24e1b067ye0a085ad9e128bfb@mail.gmail.com>
References: <19449377.post@talk.nabble.com>
	 <20080912145804.GF10544@machine.or.cz>
	 <8c5c35580809120810s69e8ec4fnf2a629d4cf575901@mail.gmail.com>
	 <200809121812.40920.johan@herland.net>
	 <20080912224817.GF10360@machine.or.cz>
	 <8c5c35580809121620x2de1828cq498b3709f7b0bd1b@mail.gmail.com>
	 <20080913194938.GI10360@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johan Herland" <johan@herland.net>, git@vger.kernel.org,
	"Jakub Narebski" <jnareb@gmail.com>,
	"=?UTF-8?Q?Kristian_H=C3=B8gsberg?=" <hoegsberg@gmail.com>
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Sep 16 00:05:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfMC3-0001Fn-Iu
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 00:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754139AbYIOWEG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 18:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754087AbYIOWEF
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 18:04:05 -0400
Received: from wf-out-1314.google.com ([209.85.200.173]:41461 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752915AbYIOWEC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 18:04:02 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2224958wfd.4
        for <git@vger.kernel.org>; Mon, 15 Sep 2008 15:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=aeltihQW/YnDnSxvxpPUFF6SkZTnLTiOrCo6u8DCUgQ=;
        b=KtcutHc3M5R9MP21sIC44oUlTxZcbmJahlrax9kjnefI6vsyLKkXGvGo7AUht3LZXr
         cK1IAaq55jLnSOakQzp1SRssCpn9AQprIbWI4kaRWvA+9gdAokjm0QvU5TwuPNZze/s3
         sL+emkG7pt86VmGXhm3QYMU6KM8jUNh6yVuMs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=gye91nZcqDG/WvsOzUSdDUOzZYnLAarV9tKSitRwg/Z/YTBOsaQ/QunKhbdhrNAD7B
         zD2qT4OotRgw0KuUgGXc4VMMS08nsxaQsSnjAwrsYkjJNeTDItkH2m5JJcMK37y3ly3u
         6GaGndJGQetbyhkGZ8aUt5dRvapt84Yj7yGtQ=
Received: by 10.114.66.2 with SMTP id o2mr132438waa.83.1221516241588;
        Mon, 15 Sep 2008 15:04:01 -0700 (PDT)
Received: by 10.114.166.20 with HTTP; Mon, 15 Sep 2008 15:04:01 -0700 (PDT)
In-Reply-To: <20080913194938.GI10360@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95948>

On Sat, Sep 13, 2008 at 9:49 PM, Petr Baudis <pasky@suse.cz> wrote:
> On Sat, Sep 13, 2008 at 01:20:50AM +0200, Lars Hjemli wrote:
>> I guess I could add support for something like
>>
>>   scan-paths=/pub/git
>>
>> in cgitrc (and optionally store the result of the scan as another
>> cgitrc-file in the cache directory). Would that improve things for
>> you?
>
> Yes, certainly.

Ok, for now I've added a --scan-tree=<path> commandline option which
will make cgit print a sorted list of the repositories found to
stdout. If/when this does a reasonable job on repo.or.cz I can look
into some form of automatic rescanning (enabled from cgitrc).


>> > Unfortunately, the recommended RewriteRule is not working - it does not
>> > play well together with query parameters cgit is using, so e.g. browsing
>> > past commits does not work.

I've also pushed support for PATH_INFO. This allows you to drop the
rewriterules from httpd.conf and the 'virtual-url' option from cgitrc
and still get the 'nice' urls.


> I wonder why
>
>        http://repo.or.cz/c/libc.git/
>
> has such a funny-looking summary page.

It's due to cgits terrible functions for parsing commits and tags.
I've pushed a reworked patch which should make the parsing more robust
and thus also render glibc.git correctly.

Finally, and probably more interesting for freedesktop.org than
repo.or.cz, is the support for repolist filtering by url prefix
(compare http://hjemli.net/git and http://hjemli.net/git/xorg for a
minimal example).

This is all available from the master branch in
git://hjemli.net/pub/git/cgit, enjoy!

--
larsh
