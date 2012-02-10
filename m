From: Tom Grennan <tmgrennan@gmail.com>
Subject: Re: [RFC/PATCH] tag: make list exclude !<pattern>
Date: Fri, 10 Feb 2012 10:55:16 -0800
Message-ID: <20120210185516.GA4903@tgrennan-laptop>
References: <1328816616-18124-1-git-send-email-tmgrennan@gmail.com>
 <CACsJy8DVXCLb50Vd0fTU+yNP2q7Gkcr88muHuzxq1jhfJW5Q9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 20:01:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvviq-0000en-IL
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 20:01:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759910Ab2BJTBX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Feb 2012 14:01:23 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:62756 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759332Ab2BJTBW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 14:01:22 -0500
Received: by qadc10 with SMTP id c10so486437qad.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 11:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Qi2OqDilQRs3p41XxI+8zGw+eD7CkqKvhYrJkFYaY/E=;
        b=iR3pScVGTyOO9FQbDCbett3j2qfz7vK0Y+vcFRf199UfHWnPjjG6pQtxluUzrMK1Q+
         OlOncIbjW2aosAPhXUYV4RSsYB80kGhDN+/IfzWn7dqLtmDzpEOmpV92fGgengZOjycn
         CAcSVDaDpo46rYGFXKk7l3eMQksyj3wCFbz18=
Received: by 10.229.77.72 with SMTP id f8mr4925670qck.34.1328900121471;
        Fri, 10 Feb 2012 10:55:21 -0800 (PST)
Received: from localhost ([129.192.185.163])
        by mx.google.com with ESMTPS id gd3sm14549244qab.6.2012.02.10.10.55.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Feb 2012 10:55:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACsJy8DVXCLb50Vd0fTU+yNP2q7Gkcr88muHuzxq1jhfJW5Q9w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190436>

On Fri, Feb 10, 2012 at 01:34:26PM +0700, Nguyen Thai Ngoc Duy wrote:
>On Fri, Feb 10, 2012 at 2:43 AM, Tom Grennan <tmgrennan@gmail.com> wro=
te:
>> Please see the following patch which filters the tag list of "!" pre=
faced
>> patterns. =A0If this is deemed desirable and correct, I'll resubmit =
with updated
>> documentation and unit tests.
>
>git-branch, git-tag and git-for-each-ref are in the same family. I
>think it's good to that all three commands share things, like this
>pattern matching.

Yes, git-branch and git-tag could now use a common match_patterns() but
git-for-each-ref needs some rearranging; as will: git-describe,
git-replace, git-ls-remote, git-name-rev, and git-show-branch.

If we pursue this, it may be best to first add match_patterns() to ./re=
fs.[ch]
then incrementally modify these builtin commands to use it.
 =20
>About the '!' for exclusion, maybe it's better to move from fnmatch()
>as matching machinery to pathspec. Then when git learns negative
>pathspec [1], we have this feature for free.
>
>[1] http://thread.gmane.org/gmane.comp.version-control.git/189645/focu=
s=3D190072

I have to study this more. I'm not sure that --exclude has precedence
over matches. It also looks like this would require a lot more change t=
o
the above.

Thanks,
TomG
