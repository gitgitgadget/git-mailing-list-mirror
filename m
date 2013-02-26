From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 12/13] Documentation/Makefile: update git guide links
Date: Mon, 25 Feb 2013 16:04:44 -0800
Message-ID: <7va9qsndnn.fsf@alter.siamese.dyndns.org>
References: <1361660761-1932-1-git-send-email-philipoakley@iee.org>
 <1361660761-1932-13-git-send-email-philipoakley@iee.org>
 <7vd2vp3qru.fsf@alter.siamese.dyndns.org> <512BF71E.3080304@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GitList <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Feb 26 01:05:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA82i-0001gK-V1
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 01:05:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755690Ab3BZAEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 19:04:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62891 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754498Ab3BZAEr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 19:04:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA722BE18;
	Mon, 25 Feb 2013 19:04:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NW9eCAhP48bZiVHKidWP0VAmKCM=; b=Lhrc4D
	zZtasJbSfKoweRMxjv5gTkfneNz5AaObIZVfH5Q86GjyhaSmQY38X5zMhvKHivpT
	e/yjgPJo/wA5aLCOln5hSe1R5EKpLjAwZhMpqayVZTJKlIWR6q0X5/RsMZyL/2CL
	YcexcR+9MFFhZ5fD42AGx1WqaNBVZHQbabIQg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TNEuncUucMNJ3fkhagyUWyLUl/gi+Osg
	dfSsq14sSoKcX0MUoSpEivx5IrBepDwdc9xAZHZ/0zKnQ3QDtUdKfcUtHAmkGpRS
	P+HtOdMVlLuAq3R2EVCcJURquiKdWRX6abekrOOA+nQQe1recMkf6uD8VKARm3US
	uFyZojFwa1Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF8F6BE17;
	Mon, 25 Feb 2013 19:04:46 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 48934BE15; Mon, 25 Feb 2013
 19:04:46 -0500 (EST)
In-Reply-To: <512BF71E.3080304@iee.org> (Philip Oakley's message of "Mon, 25
 Feb 2013 23:43:26 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 21376E64-7FA8-11E2-9C51-F3C82E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217123>

Philip Oakley <philipoakley@iee.org> writes:

> On 25/02/13 05:29, Junio C Hamano wrote:
> ...
>> In other words, can't you change the side that launches the document
>> viewer so that we do not have to rename anything in the first place?
>
> The current help code will only show either 'git-<cmd>' man pages, or
> git<guide>' pages so the current everyday and user-manual pages aren't
> served by the existing help code.

That is exactly what I meant by "the side that launches the document
viewer".  We obviously would not want to type

	$ git help gituser-manual
        $ git help giteveryday

I was wondering if you can keep document names as-is, register these
names without "git" prefix (i.e. "user-manual.html") to the list of
guide documents you are generating and compiling into the binary,
and let the user ask:

	$ git help everyday

which you would turn into "browser %s/%s.html" % (GIT_HTML_PATH, 'everyday'),
after checking "everyday" is one of the guides that are available to us.

If some guides are already named with git prefix, you can keep them
in the compiled-in list with that name.  We do not have to worry
about redirects and people's bookmarks if we can avoid renaming
existing pages, so "because grabbing everything with git* glob was
easier to write the generate-guidelist script" is a false economy.
That is the single place we can afford to spend extra effort to make
the end result easier to use by the users, no?

Or am I misreading the series completely?
