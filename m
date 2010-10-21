From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH v2 1/2] test-lib: extend test_decode_color to handle more color codes
Date: Wed, 20 Oct 2010 17:11:44 -0700
Message-ID: <389529B7-ED7E-4637-BC1C-CE9B884FAA9D@sb.org>
References: <7v4ocgx2we.fsf@alter.siamese.dyndns.org> <1287613046-61804-1-git-send-email-kevin@sb.org> <7v39s0v3f5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Nazri Ramliy <ayiehere@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 21 02:11:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8il7-0003GH-2c
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 02:11:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597Ab0JUALr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Oct 2010 20:11:47 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:35305 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752452Ab0JUALr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Oct 2010 20:11:47 -0400
Received: by pwj9 with SMTP id 9so101913pwj.19
        for <git@vger.kernel.org>; Wed, 20 Oct 2010 17:11:47 -0700 (PDT)
Received: by 10.142.242.9 with SMTP id p9mr99783wfh.417.1287619906994;
        Wed, 20 Oct 2010 17:11:46 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id v19sm1267707wfh.0.2010.10.20.17.11.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 Oct 2010 17:11:46 -0700 (PDT)
In-Reply-To: <7v39s0v3f5.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159453>

On Oct 20, 2010, at 4:40 PM, Junio C Hamano wrote:

> Kevin Ballard <kevin@sb.org> writes:
> 
>> Enhance the test_decode_color function to handle all common color codes,
>> including background colors and escapes that contain multiple codes.
>> This change necessitates changing <WHITE> to <BOLD>, so update t4034
>> as well.
>> 
>> This change is necessary for the next commit in order to test
>> background colors properly.
>> 
>> Signed-off-by: Kevin Ballard <kevin@sb.org>
>> ---
>> I turned sed into awk. Looks like awk is already used elsehwere in git,
>> so I'm assuming this is safe, but please let me know if it's not.
> 
> I think calling BOLD BOLD is the right thing to do (who came up with the
> bogus WHITE in the first place anyway---my terminal is black letters on
> white background, thank you).
> 
> Even though some scripts seem to already use awk, they are all used for
> very small and trivial processing without exercising anything remotely
> fancy e.g. hexadecimal \xXX quoting or match() function, so I wouldn't be
> surprised if we see breakage reports from minority platforms.

Entirely possible, but I'm hoping that's not the case. I used this against
BSD awk version 20070501, so there's nothing remotely fancy there, and the
regular expression conforms to the subset of BRE's mentioned in
CodingGuidelines. But as you said, it's possible that minority platforms
don't handle this correctly.

> But I do not think of a trivial way to express combination of attributes
> by extending the existing sed script (we can write loops and do the same
> computation as your awk script does, but it does not reduce the complexity
> nor risk of portability issues), so let's see what happens.  We already
> use Perl everywhere, which we might end up using for this if there are
> platforms that have issues with your awk script.

I considered writing this in Perl, but my complete lack of knowledge of Perl
made that a non-starter. However if there are any problems with the awk
script then I would welcome a Perl rewrite by someone who actually knows the
language.

-Kevin Ballard
