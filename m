From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] teach update-index --refresh about --data-unchanged
Date: Wed, 3 Nov 2010 13:36:21 -0500
Message-ID: <20101103183621.GA14019@burratino>
References: <20101031174430.GA30236@arf.padd.com>
 <20101031195933.GA21240@burratino>
 <20101031222644.GA31257@arf.padd.com>
 <20101031222805.GB31257@arf.padd.com>
 <7vzktqwbob.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pete Wyckoff <pw@padd.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 03 19:37:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDiCx-0002lC-0a
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 19:37:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486Ab0KCSgr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 14:36:47 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:49339 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932222Ab0KCSgo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 14:36:44 -0400
Received: by gxk23 with SMTP id 23so745574gxk.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 11:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ZhpJttzmfMqnGkYqgmMe2f4c8emXSvPACSRBwn29/O8=;
        b=srC0aGk1KZp8sm9QkIPGZYDWJbaiio2hlOeM9W5+Pw+n+vS4/7HrfhBuxTd83UtnRI
         lO9r7bgMMtNS1bwe6Qhio79LOhKnZo98FdGNtHbASle/hC5GmxImSvbttca/fC/OXibr
         ug+zGvebFxj6iXjWFG47J3WRzbKPbo2hzQMHU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=cn0fIfHU3TgnAEn/lfxgpit5N8vurOk8LTtJH+aUVjJS7XZLWnD1aDb+ZotJgS75mm
         lVLkkloKjElDCC0fM2RcIRwdJn38IX7I0doJA52LHNRAmyE6j69y324YCr4mIfpyw1aK
         2ozCK0jOpcVipA6twkeZf71s66dzh1BOTdAEg=
Received: by 10.42.171.1 with SMTP id h1mr628602icz.352.1288809402046;
        Wed, 03 Nov 2010 11:36:42 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id y14sm3670827vch.4.2010.11.03.11.36.39
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 03 Nov 2010 11:36:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vzktqwbob.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160633>

On Wed, Nov 03, 2010 at 10:37:40AM -0700, Junio C Hamano wrote:
> Pete Wyckoff <pw@padd.com> writes:

>> When a repository has been copied with rsync, or cloned using
>> a volume manager, the index can be incorrect even though the
>> data is unchanged.  This new flag tells update-index --refresh
>> that it is not necessary to reread the data contents.
>
> I know our traditional attitude towards the plumbing commands have been
> "give them long enough rope and let users hang themselves", but this
> particular rope feels a bit too long for my taste.

Pete, I think you mentioned the possibility of a special-case tool for
contrib/ that just updates the inode, device number, and ctime fields?
That sounds a little less worrying to use, as plumbing.
