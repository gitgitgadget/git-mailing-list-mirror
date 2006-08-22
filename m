From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Paginate history output
Date: Tue, 22 Aug 2006 10:08:47 +0200
Organization: At home
Message-ID: <ecee2g$b0l$1@sea.gmane.org>
References: <200608220053.10741.jnareb@gmail.com> <7vveols3c7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Aug 22 10:09:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFRJj-0005ZK-Ef
	for gcvg-git@gmane.org; Tue, 22 Aug 2006 10:08:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbWHVII4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Aug 2006 04:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbWHVIIz
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 04:08:55 -0400
Received: from main.gmane.org ([80.91.229.2]:40875 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751346AbWHVIIy (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Aug 2006 04:08:54 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GFRJd-0005Yd-EW
	for git@vger.kernel.org; Tue, 22 Aug 2006 10:08:53 +0200
Received: from host-81-190-21-215.torun.mm.pl ([81.190.21.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 22 Aug 2006 10:08:53 +0200
Received: from jnareb by host-81-190-21-215.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 22 Aug 2006 10:08:53 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-215.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25837>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> @@ -1559,6 +1562,7 @@ sub git_history_body {
>>                      next;
>>              }
>>  
>> +            #my $ref = defined $refs ? format_ref_marker($refs, $commit) : '';
>>              my $ref = format_ref_marker($refs, $commit);
>>  
>>              if ($alternate) {
> 
> Do you want to change this or not?  Make up your mind.

I'm not sure. This is an internal function, so $refs should 
be defined. I'm not sure checking here is worth it.

This whole hunk could be removed.

>> +            $paging_nav .= " &sdot; " .
>> +                    $cgi->a({-href => href(action=>"history", hash=>$hash, hash_base=>$hash_base,
>> +                                           file_name=>$file_name, page=>$page-1),
>> +                             -accesskey => "p", -title => "Alt-p"}, "prev");
> 
> This is something you inherited from the original and not your
> fault, but I am not sure if these -title entries are of good
> taste (we have corresponding "Alt-n" for "next").  Something
> more descriptive like "<Alt-p> for 100 newer changes", perhaps?

That would be better.

> Also, "first", "prev" and "next" have always confused me.  Maybe
> "latest", "older" and "newer" are better labels for them?

"first" is only for pagination of "history" action, "shortlog",
"heads" and "tags" have "HEAD" there instead.

> Is 100 a good default?  It feels a bit unbalanced compared to
> the height of the default summary page with descriptions, 16
> shortlog entries, 16 tags and 12 heads.

It's 16 heads (if you have that many), from what I remember 
from source.

The purpose of summary page is to have everything at glance (it means
that it should be contained in one, two pages. The pagination of
output is to not send too much at once.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
