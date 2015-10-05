From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 2/4] Consolidate code to close a pack's file descriptor
Date: Mon, 05 Oct 2015 23:52:06 +0200
Organization: gmx
Message-ID: <b7d0f89bb94f88cb8d600a461dfe7ea1@dscho.org>
References: <682991036f1e8e974ed8ecd7d20dbcc6fb86c344.1443469464.git.johannes.schindelin@gmx.de>
 <cover.1444076827.git.johannes.schindelin@gmx.de>
 <a1f0d9339a9de95ba3f5eaaaf2e1a712629ad5d4.1444076827.git.johannes.schindelin@gmx.de>
 <xmqqio6lxcci.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Max Kirillov <max@max630.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 23:52:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjDgB-0000eu-5m
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 23:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbbJEVwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 17:52:15 -0400
Received: from mout.gmx.net ([212.227.15.19]:55017 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750780AbbJEVwO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 17:52:14 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MBExR-1ZtMYs2GCD-00ABnZ; Mon, 05 Oct 2015 23:52:07
 +0200
In-Reply-To: <xmqqio6lxcci.fsf@gitster.mtv.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:bn890BZxGs/ejZIoJ/0kWmSsy6g6OVU16h8j4TqJY3crc5R54ec
 w4bvU9tAiyDobFa8Bf2/r/s7fFVefbjaRjeoiWYzg4PC2CBBmWvgsHcR1Fb8sIwdXIr/w73
 I3eXA7mDcvLcFkGLNMyF/QsbZk5UnGO7h+woMT0UU5oWLUaCk438bFxYBgzlGCURuava8mu
 EIYnuit0uK1JQVC6ANYzw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:m9sTf0YMxv8=:4UNwATybuOzKEtC3sx0ihK
 vpbd7b/wj3Kvh1OzGm2jVq+2JcxK3woJVnJA+MY4p0JRCYDUUFNQPoYqb0EQNX8ilFqy2f3PX
 w48+JzIBaQOpmkRuOEYTtwRBTviQD7nRr4wEBjmGx6irEuJJvkxlc0B9Rye725Cn8G6y2SO2J
 JLsR3JcBbB2oFuo8aU/qdnGmBxTMjQ9BwJ8Dcso8CXuXE+8Tke6fuAJPBB95nUYVGH+UT5ADd
 0HDhWuF7Oz9m9Hcfj/uBHvbZj3K9HyeR1tkykK5CwvbDNLT23eBj98pSTZrClZGzXwWePDIIk
 lRMbYKqS5yEGU4Sv6d8pOSp9xbP7y9qw4ocl7hET3W8FI2k6EyjZKpi8BonP+DXW5QFLKdPtz
 HiUBFpOzFB4C0QDDgWfAvSs7BLgsLL2mrs3C3HPxn7pfPhdtZVpwyxOZGvw2TKq22TpZDIaYp
 2NmHBS6lTCdZ06zcdUK/XZYyNGnwsp1BR8Kl8NyWFRiSq8DEi5ze6Nj8bYmwhq9IEONV3QEzt
 LBvBD9hMqBosGQrsCjaeO77JtXivPqfOzsjHXhxCHxrI3fRAgcuR37TQcK532RJcYGinKra0P
 qhJuXab2Yo+IO4YAAK0A1JyIBbQpuPQ/B0/zVLd+qmbxS5OIOpWzO3K2jp17uuqM+mvOPKtgr
 Nk5aKnfFSbH80WljRzWa+Y4aU3sDbWVvNJPg2ev+ew2m3OWFCc7d3qObBowHsxVjXCyki2AFZ
 7iDFx2hA8mlEXDOi/BEHixzDGsNg5T7ntjuyBPz3drRFNsuDRAgmSDVLSZXvGy+ek/fdtUgo 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279099>

Hi Junio,

On 2015-10-05 22:57, Junio C Hamano wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
>> There was a lot of repeated code to close the file descriptor of
>> a given pack. Let's just refactor this code into a single function.
> 
> That is a very good idea, but...
> 
>> +static int close_pack_fd(struct packed_git *p)
>> +{
>> +	if (p->pack_fd < 0)
>> +		return 0;
> 
> Is this "return 0" compatible with ...
> 
>> +	close(p->pack_fd);
>> +	pack_open_fds--;
>> +	p->pack_fd = -1;
>> +
>> +	return 1;
>> +}
>> +
>>  /*
>>   * The LRU pack is the one with the oldest MRU window, preferring packs
>>   * with no used windows, or the oldest mtime if it has no windows allocated.
>> @@ -853,12 +865,8 @@ static int close_one_pack(void)
>>  		find_lru_pack(p, &lru_p, &mru_w, &accept_windows_inuse);
>>  	}
>>
>> -	if (lru_p) {
>> -		close(lru_p->pack_fd);
>> -		pack_open_fds--;
>> -		lru_p->pack_fd = -1;
>> -		return 1;
>> -	}
>> +	if (lru_p)
>> +		return close_pack_fd(lru_p);
> 
> ... what is returned from here?

Yes. At this point, `lru_p` can only be non-NULL if lru_p->pack_fd is not larger than 0 (hence the call to `close(lru_p->pack_fd)` does not fail all the time, and hence the `pack_open_fds--` does not result in inconsistent state).

> It seems to me that it would be a bug if (p->pack_fd < 0) in this
> codepath, so in practice nobody will receive a newly invented return
> value 0 from this function, but it feels wrong.

Yes, it would be a bug. And more subtle things would go wrong if that was the case, too.

> 
>>  	return 0;
>>  }
>> @@ -899,10 +907,7 @@ void free_pack_by_name(const char *pack_name)
>>  		if (strcmp(pack_name, p->pack_name) == 0) {
>>  			clear_delta_base_cache();
>>  			close_pack_windows(p);
>> -			if (p->pack_fd != -1) {
>> -				close(p->pack_fd);
>> -				pack_open_fds--;
>> -			}
>> +			close_pack_fd(p);
> 
> And here, the closer _must_ be (and it currently is) very aware that
> the pack chosen may not be open anymore.  By giving a function that
> conditionally closes if the pack is still open too bland a name,
> that distinction is lost at these two call sites.

Please note that the `close_pack_fd(p)` call does not invalidate the data. It is the caller (`free_pack_by_name()`) that does. Which is safe.

> Also closing "fd" is not the only thing the new helper does, so in
> that sense its name is suboptimal, too.

Yes, it also decrements the counter. But that is a necessary consequence of closing the file descriptor, otherwise the state would be inconsistent.

> Perhaps a new helper function that is close_pack(), which is
> unconditional, with another close_pack_if_open() around it?

Next patch. And that `close_pack()` actually does do more than closing the file descriptor.

>>  			if (!win->offset && win->len == p->pack_size
>> -				&& !p->do_not_close) {
>> -				close(p->pack_fd);
>> -				pack_open_fds--;
>> -				p->pack_fd = -1;
>> -			}
>> +				&& !p->do_not_close)
>> +				close_pack_fd(p);
> 
> I wonder how this do_not_close bit should interact with "we are
> shutting down (or we are spawning another to do the real work, while
> we won't do anything useful anymore), so close everything down".

The `close_all_packs()` function is meant for the use case where you really close all the packs, no question asked.

I cannot think of a use case where it would make sense to try to be gentle, yet still ask for *all* of the packs to be closed. Maybe you can think of one to convince me that it might make sense to respect the `do_not_close` flag in such a function? Because so far, I am totally unconvinced.

Ciao,
Johannes
