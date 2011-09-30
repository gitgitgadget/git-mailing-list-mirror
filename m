From: Luke Diamand <luke@diamand.org>
Subject: Re: [RFC/PATCHv2] git-p4: handle files with shell metacharacters
Date: Fri, 30 Sep 2011 10:06:06 +0100
Message-ID: <4E85867E.2050805@diamand.org>
References: <20110926214758.GB3433@arf.padd.com> <1317112836-14135-1-git-send-email-luke@diamand.org> <20110927130334.GA24327@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Fri Sep 30 11:06:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9Z36-0001zX-9p
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 11:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757577Ab1I3JGR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Sep 2011 05:06:17 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59100 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755201Ab1I3JGK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2011 05:06:10 -0400
Received: by wyg34 with SMTP id 34so864546wyg.19
        for <git@vger.kernel.org>; Fri, 30 Sep 2011 02:06:09 -0700 (PDT)
Received: by 10.216.170.204 with SMTP id p54mr284035wel.51.1317373569006;
        Fri, 30 Sep 2011 02:06:09 -0700 (PDT)
Received: from [86.26.7.206] (cpc1-cmbg14-2-0-cust973.5-4.cable.virginmedia.com. [86.26.7.206])
        by mx.google.com with ESMTPS id fr18sm8120266wbb.9.2011.09.30.02.06.07
        (version=SSLv3 cipher=OTHER);
        Fri, 30 Sep 2011 02:06:07 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:6.0.2) Gecko/20110902 Thunderbird/6.0.2
In-Reply-To: <20110927130334.GA24327@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182472>

On 27/09/11 14:03, Pete Wyckoff wrote:

<snip>


>
> If you don't mind, I'll just queue it up with the utf16 and
> test-refactor stuff I have, and send it all to Junio post-1.7.7.
> Here's how I plan to adjust your tests, given the feedback that
> Junio gave earlier and from reading other tests in t/.
>
> 		-- Pete


Pete - I've just noticed that t9803 sets P4EDITOR up for the wrong commit.

It works fine for me in my the setup I've got at home but on another 
setup hangs trying to run vi from within the test.

It looks like two or possibly three bugs combine with each other.

(a) my misplacement of P4EDITOR

(b) git-p4 doesn't check the return code from system(editor + fileName) 
at around 1018, so it just carries blithely on.

(c) "git var GIT_EDITOR" called from within the test harness gives 
differing results. In one setup I get "vi", in another, nothing. The 
tests pass in the latter case.

I'll submit a new patch series to fix (a) and (b). I'm not sure if (c) 
is a bug or a feature. If I get very keen I might also include a tidied 
up version of the recent patch for turning off the editor explicitly.

Luke
