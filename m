From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: remove_duplicates() in builtin/fetch-pack.c is O(N^2)
Date: Tue, 22 May 2012 15:35:22 +0200
Message-ID: <4FBB961A.2030806@alum.mit.edu>
References: <4FB9F92D.8000305@alum.mit.edu> <20120521174525.GA22643@sigill.intra.peff.net> <CACsJy8Dw+mbP+ttTP6gAfX9o4q4NyZgPYpbhS=tket=5fvBXwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 22 15:42:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWpM8-0004E6-DX
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 15:42:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754117Ab2EVNm1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 09:42:27 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:49303 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751505Ab2EVNm0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 May 2012 09:42:26 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 May 2012 09:42:25 EDT
X-AuditID: 1207440d-b7f336d00000097b-d4-4fbb961b8898
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id F8.CC.02427.B169BBF4; Tue, 22 May 2012 09:35:23 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q4MDZMMk009727
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 22 May 2012 09:35:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <CACsJy8Dw+mbP+ttTP6gAfX9o4q4NyZgPYpbhS=tket=5fvBXwg@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsUixO6iqCs9bbe/wcNXphZdV7qZLBp6rzBb
	dE95y2jxo6WH2YHFY+esu+wez3r3MHpcvKTs8XmTXABLFLdNUmJJWXBmep6+XQJ3RtfffvaC
	r9wVL7ZNY21gPMTZxcjJISFgInH14lYmCFtM4sK99WxdjFwcQgKXGSX2zdrBDpIQEjjOJLHk
	liqIzSugLbHo4Q9GEJtFQFXi/P29YM1sAroSi3qagWwODlGBMInVDzQgygUlTs58wgJiiwjo
	SJy8cwWslVmgVOLBh79grcICThIrfkxlhdg7n1Fi8vcWNpA5nAKBEhPmlkPUm0l0be2C6pWX
	2P52DvMERoFZSFbMQlI2C0nZAkbmVYxyiTmlubq5iZk5xanJusXJiXl5qUW6Rnq5mSV6qSml
	mxghwcy7g/H/OplDjAIcjEo8vI6Vu/yFWBPLiitzDzFKcjApifIqTd3tL8SXlJ9SmZFYnBFf
	VJqTWnyIUYKDWUmEd1MbUDlvSmJlVWpRPkxKmoNFSZxXbYm6n5BAemJJanZqakFqEUxWhoND
	SYI3FmSoYFFqempFWmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPChO44uBkQqS4gHaOxOknbe4
	IDEXKArReopRl2PGp0XXGIVY8vLzUqXEeVNBigRAijJK8+BWwFLXK0ZxoI+FeQNBqniAaQ9u
	0iugJUxAS4Je7ARZUpKIkJJqYJx7/rkWK5/y9ulMfRO+6E9+soNxov+qz5eOreMKavwoZ3aR
	a3Xzk745LywSNK5v6UqdwCPtu/fe/b9rX0X/Kk/u3ahUuUF5+bl5n1RKphv8/9R3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198199>

On 05/22/2012 02:18 PM, Nguyen Thai Ngoc Duy wrote:
> On Tue, May 22, 2012 at 12:45 AM, Jeff King<peff@peff.net>  wrote:
>> The rails/rails network repository at GitHub (i.e., a master repo with
>> all of the objects and refs for all of the forks) has about 400K refs,
>> and has been the usual impetus for me finding and fixing these sorts of
>> quadratic problems.
>
> Off topic and pure speculation. With 400k refs, each one 20 byte in
> length, the pathname part only can take 7MB. Perhaps packed-refs
> should learn prefix compressing too, like index v4, to reduce size
> (and hopefully improve startup speed). Compressing refs/heads/ and
> refs/tags/ only could gain quite a bit already.

I considered this idea but put it off for now for the reasons explained 
in the docstring for struct ref_entry in refs.c:

  * Please note that the name field contains the fully-qualified
  * reference (or subdirectory) name.  Space could be saved by only
  * storing the relative names.  But that would require the full names
  * to be generated on the fly when iterating in do_for_each_ref(), and
  * would break callback functions, who have always been able to assume
  * that the name strings that they are passed will not be freed during
  * the iteration.

Thus, all of the callers of the for_each_ref functions would have to be 
audited (and perhaps adjusted) before such a change could be implemented.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
