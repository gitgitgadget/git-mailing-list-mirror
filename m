From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/4 v4] minor gitweb modifications
Date: Sat, 1 Jan 2011 04:41:21 -0600
Message-ID: <20110101104121.GA12734@burratino>
References: <1293744031-17790-1-git-send-email-sylvain@abstraction.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Sylvain Rabot <sylvain@abstraction.fr>
X-From: git-owner@vger.kernel.org Sat Jan 01 11:44:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PYyxA-0007ls-32
	for gcvg-git-2@lo.gmane.org; Sat, 01 Jan 2011 11:44:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752012Ab1AAKle (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Jan 2011 05:41:34 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44969 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726Ab1AAKld (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jan 2011 05:41:33 -0500
Received: by iwn9 with SMTP id 9so12175203iwn.19
        for <git@vger.kernel.org>; Sat, 01 Jan 2011 02:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=wvvErRECz2wFW3xvJBJms/WlZkbiqiqTEMZGtrgdhgU=;
        b=KLKzHlQ+KaWahII6FGaG0GIAmBV+Ke3rN7Vxq1aTv9YUaWRuv0Zs1uSAlKP6weVP6p
         fdut2qHNRlT3BYx6iohe6equVr9X5xFHLNSxQ3Hrg+H5bS19ZjVPwotZfGtuL3nYA2ir
         5q+q3kl1qiOHl1DJVjNn99FQqA6KOUGfO5t28=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=td90LM1C2BwZ4VOulI15sgJ9XQCjHk4Gdp7FpHD7SIVfoDPLd9+J/AB5JaDHqHPmBf
         TqXgdQ9J7CW2BSpuMVG/NAkHA3ROzKA4aygfRhP8iwJu78mLsdXsOHb+Y9875t8eJx5E
         F+8WY93AeKAR0HwEhQtkW0S1KQ08mkQBG9S1U=
Received: by 10.42.164.202 with SMTP id h10mr18901321icy.110.1293878491259;
        Sat, 01 Jan 2011 02:41:31 -0800 (PST)
Received: from burratino (c-76-126-174-171.hsd1.ca.comcast.net [76.126.174.171])
        by mx.google.com with ESMTPS id c4sm15527408ict.19.2011.01.01.02.41.28
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 01 Jan 2011 02:41:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1293744031-17790-1-git-send-email-sylvain@abstraction.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164401>

(adding back cc: jakub)

Hi,

Sylvain Rabot wrote:

>   gitweb: add extensions to highlight feature map
>   gitweb: remove unnecessary test when closing file descriptor

I like the above two.

>   gitweb: add css class to remote url titles

I had a question (why make the remote url table inconsistent with the
older projects_list table) and suggested a more generic approach in
reply to v2[1]:

	<table class="projects_list">
	<tr id="metadata_desc">
		<td class="metadata_tag">description</td>
		<td>Unnamed repository; edit this file to name it for gitweb.</td>
	</tr>
	<tr id="metadata_owner">
		<td class="metadata_tag">owner</td>
		<td>UNKNOWN</td>
	</tr>
	...

The idea was that the rows are already labelled for use by css, so to
make this stylable all we need to do is use a class for the first
column.  This way if some site operator wants the first column
*always* be bold then that is easy to do.

Another approach with similar effect would be

	<dl class="projects_list">
	<dt>description</dt>
	<dd id="metadata_desc"
		>Unnamed repository; edit this file to name it for gitweb</dd>
	<dt>owner>
	<dd id="metadata_owner"
		>UNKNOWN</dd>
	...

but that does not degrade as well to browsers not supporting css.  Any
thoughts on this?

>   gitweb: add vim modeline header which describes gitweb coding rule

I don't like this one.  Isn't the tabstop whatever the reader wants it
to be (e.g., 8)?  I don't like modelines as a way of documenting
coding standards because

 (1) they are not clear to humans and editors other than vim
 (2) they require annotating each source file separately.

See [1] for an alternative approach to configuring an editor to hack
on git.

Regards,
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/109462/focus=109538
